import 'dart:io' show Directory;
import 'dart:ui' show Locale, PlatformDispatcher;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'agent/tool_contract.dart';
import 'ai/relay_client.dart';
import 'db/connection.dart';
import 'db/database.dart';
import 'documents/blob_store.dart';
import 'documents/document_repository.dart';
import 'documents/text_extractor.dart';
import 'life/life_repository.dart';
import 'locale.dart';
import 'memory/memory_repository.dart';
import 'permissions/permission_repository.dart';
import 'planner/notification_scheduler.dart';
import 'planner/planner_repository.dart';
import 'security/app_lock.dart';
import 'security/authenticator.dart';
import 'security/key_store.dart';
import '../l10n/app_localizations.dart';

export 'locale.dart' show sharedPreferencesProvider;

final clockProvider = Provider<DateTime Function()>((ref) => DateTime.now);

final secretStoreProvider = Provider<SecretStore>((ref) => const SecureStorageSecretStore());

final keyStoreProvider = Provider<KeyStore>((ref) => KeyStore(ref.watch(secretStoreProvider)));

final authenticatorProvider = Provider<Authenticator>((ref) => LocalAuthAuthenticator());

final appLockProvider = NotifierProvider<AppLockController, LockStatus>(AppLockController.new);

/// Opened only after unlock: nothing reads it until the lock gate shows the app.
final databaseProvider = FutureProvider<LifeDatabase>((ref) async {
  final db = await openLifeDatabase(ref.watch(keyStoreProvider));
  ref.onDispose(db.close);
  return db;
});

final toolRegistryProvider = FutureProvider<ToolRegistry>((ref) async {
  return ToolRegistry.fromContractJson(await rootBundle.loadString('assets/contracts/agent-tools.json'));
});

final permissionRepositoryProvider = FutureProvider<PermissionRepository>((ref) async {
  final repo = PermissionRepository(
    await ref.watch(databaseProvider.future),
    await ref.watch(toolRegistryProvider.future),
    clock: ref.watch(clockProvider),
  );
  await repo.seedDefaults();
  return repo;
});

final memoryRepositoryProvider = FutureProvider<MemoryRepository>((ref) async {
  return MemoryRepository(await ref.watch(databaseProvider.future), clock: ref.watch(clockProvider));
});

/// Android notifications. The channel name appears in system settings, so it
/// follows the device language.
final notificationSchedulerProvider = FutureProvider<NotificationScheduler>((ref) async {
  final device = PlatformDispatcher.instance.locale;
  final l = AppLocalizations.delegate.isSupported(device) ? lookupAppLocalizations(device) : lookupAppLocalizations(const Locale('en'));
  return LocalNotificationScheduler.create(channelName: l.reminderChannel);
});

final plannerRepositoryProvider = FutureProvider<PlannerRepository>((ref) async {
  return PlannerRepository(
    await ref.watch(databaseProvider.future),
    await ref.watch(notificationSchedulerProvider.future),
    clock: ref.watch(clockProvider),
  );
});

/// Encrypted document files live in the app's private support directory.
final blobStoreProvider = FutureProvider<BlobStore>((ref) async {
  final dir = await getApplicationSupportDirectory();
  final keys = ref.watch(keyStoreProvider);
  return EncryptedBlobStore(Directory(p.join(dir.path, 'documents')), keys.fileKey);
});

final textExtractorProvider = Provider<TextExtractor>((ref) => DeviceTextExtractor());

final documentRepositoryProvider = FutureProvider<DocumentRepository>((ref) async {
  return DocumentRepository(
    await ref.watch(databaseProvider.future),
    await ref.watch(blobStoreProvider.future),
    ref.watch(textExtractorProvider),
    await ref.watch(plannerRepositoryProvider.future),
    clock: ref.watch(clockProvider),
  );
});

final lifeRepositoryProvider = FutureProvider<LifeRepository>((ref) async {
  return LifeRepository(
    await ref.watch(databaseProvider.future),
    await ref.watch(plannerRepositoryProvider.future),
    clock: ref.watch(clockProvider),
  );
});

final relayCredentialsProvider = FutureProvider<RelayCredentials?>((ref) => ref.watch(keyStoreProvider).relayCredentials());

/// Overridable so tests can inject an HTTP mock.
final relayClientFactoryProvider = Provider<RelayClient Function(RelayCredentials)>((ref) => RelayClient.new);

/// Whether the first-run welcome has been completed.
final onboardedProvider = NotifierProvider<OnboardedController, bool>(OnboardedController.new);

class OnboardedController extends Notifier<bool> {
  static const _key = 'onboarded_v1';

  @override
  bool build() => ref.watch(sharedPreferencesProvider).getBool(_key) ?? false;

  Future<void> complete() async {
    await ref.read(sharedPreferencesProvider).setBool(_key, true);
    state = true;
  }
}
