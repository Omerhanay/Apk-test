import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Languages the app ships. Names are shown in their own language.
///
/// Uppercase section headers are stored uppercased in the ARB files, because
/// Dart's toUpperCase() is not locale-aware (Turkish i must become İ, not I).
const supportedLanguages = {'en': 'English', 'tr': 'Türkçe'};

/// Provided in main() after SharedPreferences loads; overridden in tests.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) => throw UnimplementedError());

/// The user's chosen language, or null to follow the device.
final localeProvider = NotifierProvider<LocaleController, Locale?>(LocaleController.new);

class LocaleController extends Notifier<Locale?> {
  static const _key = 'locale';

  @override
  Locale? build() {
    final code = ref.watch(sharedPreferencesProvider).getString(_key);
    return code != null && supportedLanguages.containsKey(code) ? Locale(code) : null;
  }

  Future<void> select(Locale? locale) async {
    final prefs = ref.read(sharedPreferencesProvider);
    if (locale == null) {
      await prefs.remove(_key);
    } else {
      await prefs.setString(_key, locale.languageCode);
    }
    state = locale;
  }
}
