import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/design/theme.dart';
import 'core/locale.dart';
import 'core/router.dart';
import 'features/lock/lock_gate.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [sharedPreferencesProvider.overrideWithValue(prefs)],
    child: const LifeOsApp(),
  ));
}

class LifeOsApp extends ConsumerStatefulWidget {
  const LifeOsApp({super.key});

  @override
  ConsumerState<LifeOsApp> createState() => _LifeOsAppState();
}

class _LifeOsAppState extends ConsumerState<LifeOsApp> {
  final _router = buildRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'LIFE OS',
      debugShowCheckedModeBanner: false,
      theme: LifeTheme.light(),
      darkTheme: LifeTheme.dark(),
      // null follows the device language; unsupported device languages fall back to English.
      locale: ref.watch(localeProvider),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      routerConfig: _router,
      // Everything behind the router stays unbuilt until the app is unlocked.
      builder: (context, child) => LockGate(child: child!),
    );
  }
}
