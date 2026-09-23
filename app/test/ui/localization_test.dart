import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:life_os/features/today/today_screen.dart';
import 'package:life_os/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'test_app.dart';

Map<String, dynamic> _arb(String code) =>
    jsonDecode(File('lib/l10n/app_$code.arb').readAsStringSync()) as Map<String, dynamic>;

Set<String> _messageKeys(Map<String, dynamic> arb) => arb.keys.where((k) => !k.startsWith('@')).toSet();

void main() {
  test('Turkish translates every English message', () {
    expect(_messageKeys(_arb('tr')), _messageKeys(_arb('en')));
  });

  test('section headers are stored fully uppercased', () {
    // Headers are uppercased in the ARB files, not in code, because Dart's
    // toUpperCase() maps Turkish i to I instead of İ.
    const headerKeys = [
      'todayHappening', 'todayAttention', 'settingsTrust', 'settingsConnection',
      'settingsSafety', 'settingsPreferences', 'settingsYourData', 'permissionsRead', 'permissionsAct',
    ];
    for (final code in ['en', 'tr']) {
      final arb = _arb(code);
      for (final key in headerKeys) {
        final value = arb[key] as String;
        expect(value.contains(RegExp('[a-zçğıöşü]')), isFalse, reason: '$code.$key = $value');
      }
    }
  });

  testWidgets('a saved Turkish choice renders the app in Turkish', (tester) async {
    final h = TestHarness(prefs: {'onboarded_v1': true, 'locale': 'tr'});
    await tester.pumpWidget(await h.build());
    await tester.pumpAndSettle();
    expect(find.text('LIFE OS kilitli'), findsOneWidget);
    await tester.tap(find.text('Kilidi aç'));
    await tester.pumpAndSettle();

    for (final label in ['Bugün', 'Görevler', 'Belgeler', 'Yaşam', 'Hafıza']) {
      expect(find.descendant(of: find.byType(NavigationBar), matching: find.text(label)), findsOneWidget);
    }
    expect(find.text('DİKKAT GEREKTİRENLER'), findsOneWidget);
    await h.dispose(tester);
  });

  testWidgets('dates use Turkish month and day names', (tester) async {
    await tester.pumpWidget(MaterialApp(
      locale: const Locale('tr'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Scaffold(body: TodayHeader(now: DateTime(2026, 9, 22, 9))),
    ));
    await tester.pumpAndSettle();
    expect(find.text('Günaydın'), findsOneWidget);
    expect(find.text('22 Eylül Salı'), findsOneWidget);
  });

  testWidgets('an unsupported device language falls back to English', (tester) async {
    tester.platformDispatcher.localesTestValue = const [Locale('de')];
    addTearDown(tester.platformDispatcher.clearLocalesTestValue);
    final h = TestHarness();
    await h.pumpUnlocked(tester);
    expect(find.descendant(of: find.byType(NavigationBar), matching: find.text('Today')), findsOneWidget);
    await h.dispose(tester);
  });

  testWidgets('choosing Türkçe in settings switches language and persists it', (tester) async {
    final h = TestHarness();
    await h.pumpUnlocked(tester);

    await tester.tap(find.byTooltip('Settings and privacy'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Language'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Türkçe'));
    await tester.pumpAndSettle();

    expect(find.text('Ayarlar ve gizlilik'), findsOneWidget);
    expect(find.text('Dil'), findsOneWidget);
    expect((await SharedPreferences.getInstance()).getString('locale'), 'tr');

    await tester.tap(find.text('Dil'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sistem varsayılanı'));
    await tester.pumpAndSettle();
    expect((await SharedPreferences.getInstance()).getString('locale'), isNull);
    await h.dispose(tester);
  });
}
