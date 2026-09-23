import 'dart:io';
import 'dart:typed_data';

import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/core/agent/tool_contract.dart';
import 'package:life_os/core/ai/relay_client.dart';
import 'package:life_os/core/db/database.dart';
import 'package:life_os/core/documents/blob_store.dart';
import 'package:life_os/core/documents/text_extractor.dart';
import 'package:life_os/features/documents/add_document.dart';
import 'package:life_os/features/documents/document_picker.dart';
import 'package:life_os/core/planner/notification_scheduler.dart';
import 'package:life_os/core/providers.dart';
import 'package:life_os/core/security/authenticator.dart';
import 'package:life_os/core/security/key_store.dart';
import 'package:life_os/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FakeAuthenticator implements Authenticator {
  FakeAuthenticator([this.outcome = AuthOutcome.success]);
  AuthOutcome outcome;
  int calls = 0;

  @override
  Future<AuthOutcome> authenticate(String reason) async {
    calls++;
    return outcome;
  }
}

class FakeNotifications implements NotificationScheduler {
  final scheduled = <String, ScheduledNotification>{};
  int permissionRequests = 0;

  @override
  Future<void> schedule(ScheduledNotification n) async => scheduled[n.key] = n;
  @override
  Future<void> cancel(String key) async => scheduled.remove(key);
  @override
  Future<bool> requestPermission() async {
    permissionRequests++;
    return true;
  }
}

/// In-memory files: widget tests can't do real file I/O. Encryption itself is
/// covered by test/documents/document_core_test.dart.
class MemoryBlobStore implements BlobStore {
  final files = <String, Uint8List>{};
  var _n = 0;
  @override
  Future<String> write(Uint8List plain) async {
    final name = 'blob${_n++}';
    files[name] = plain;
    return name;
  }

  @override
  Future<Uint8List> read(String name) async => files[name]!;
  @override
  Future<void> delete(String name) async => files.remove(name);
}

class FakeTextExtractor implements TextExtractor {
  final pagesByContent = <String, List<String>>{};
  @override
  Future<List<String>> extract(Uint8List bytes, String mimeType) async =>
      pagesByContent[String.fromCharCodes(bytes)] ?? const [];
}

class FakePicker implements DocumentPicker {
  PickedDocument? next;
  @override
  Future<PickedDocument?> pickFile() async => next;
  @override
  Future<PickedDocument?> takePhoto() async => next;
}

class MemorySecretStore implements SecretStore {
  final values = <String, String>{};
  @override
  Future<String?> read(String key) async => values[key];
  @override
  Future<void> write(String key, String value) async => values[key] = value;
  @override
  Future<void> delete(String key) async => values.remove(key);
}

/// The real app wired to fakes: in-memory database, secrets and preferences,
/// and a scriptable authenticator.
class TestHarness {
  TestHarness({
    AuthOutcome authOutcome = AuthOutcome.success,
    this.prefs = const {'onboarded_v1': true},
    this.relayClient,
  }) : auth = FakeAuthenticator(authOutcome);

  final FakeAuthenticator auth;
  final Map<String, Object> prefs;
  final RelayClient Function(RelayCredentials)? relayClient;
  final secrets = MemorySecretStore();
  final notifications = FakeNotifications();
  final blobs = MemoryBlobStore();
  final ocr = FakeTextExtractor();
  final picker = FakePicker();
  final db = LifeDatabase(NativeDatabase.memory());
  DateTime now = DateTime(2026, 9, 22, 9);

  Future<Widget> build() async {
    SharedPreferences.setMockInitialValues(prefs);
    final instance = await SharedPreferences.getInstance();
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(instance),
        authenticatorProvider.overrideWithValue(auth),
        secretStoreProvider.overrideWithValue(secrets),
        clockProvider.overrideWithValue(() => now),
        databaseProvider.overrideWith((ref) async => db),
        // rootBundle does real I/O, which never completes inside testWidgets' fake async zone.
        toolRegistryProvider.overrideWith(
            (ref) async => ToolRegistry.fromContractJson(File('assets/contracts/agent-tools.json').readAsStringSync())),
        notificationSchedulerProvider.overrideWith((ref) async => notifications),
        blobStoreProvider.overrideWith((ref) async => blobs),
        textExtractorProvider.overrideWithValue(ocr),
        documentPickerProvider.overrideWithValue(picker),
        if (relayClient != null) relayClientFactoryProvider.overrideWithValue(relayClient!),
      ],
      child: const LifeOsApp(),
    );
  }

  /// Pumps the app and taps through the lock screen.
  Future<void> pumpUnlocked(WidgetTester tester) async {
    await tester.pumpWidget(await build());
    await tester.pumpAndSettle();
    await tester.tap(find.byType(FilledButton));
    await tester.pumpAndSettle();
  }

  /// Tears down the widget tree and database so no stream timers outlive the test.
  Future<void> dispose(WidgetTester tester) async {
    await tester.pumpWidget(const SizedBox());
    // Drift cleans up cancelled stream queries on timers, which only fire as
    // fake time advances; close() waits for that cleanup.
    await tester.pump(const Duration(seconds: 1));
    final closing = db.close();
    await tester.pump(const Duration(seconds: 1));
    await closing;
  }
}
