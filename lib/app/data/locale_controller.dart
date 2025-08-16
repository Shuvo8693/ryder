import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ryder/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleController extends GetxController {
  static const List<Locale> supportedLocales = [
    Locale('en', 'US'),
    Locale('es', 'ES'),
    Locale('fr', 'FR'),
  ];

  final _locale = const Locale('en', 'US').obs;
  final _isLoading = false.obs;

  Locale get locale => _locale.value;
  bool get isLoading => _isLoading.value;

  @override
  void onInit() {
    super.onInit();
    loadLocale();
  }
/// ==== Set language ======
  void setLocale(Locale locale) {
    if (!supportedLocales.contains(locale)) return;

    _locale.value = locale;
    Get.updateLocale(locale);
    _saveLocaleToPrefs(locale);

    // Show snackbar for confirmation
    Get.snackbar(
      'Language Changed',
      'Language has been changed to ${getLanguageName(locale)}',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
  /// ==== Fetch saved language ======
  Future<void> loadLocale() async {
    try {
      _isLoading.value = true;
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString('language_code') ?? 'en';
      final countryCode = prefs.getString('country_code') ?? 'US';

      final savedLocale = Locale(languageCode, countryCode);

      if (supportedLocales.contains(savedLocale)) {
        _locale.value = savedLocale;
        Get.updateLocale(savedLocale);
      }
    } catch (e) {
      debugPrint('Error loading locale: $e');
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> _saveLocaleToPrefs(Locale locale) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('language_code', locale.languageCode);
      await prefs.setString('country_code', locale.countryCode ?? '');
    } catch (e) {
      debugPrint('Error saving locale: $e');
    }
  }

  String get currentLanguageName => getLanguageName(_locale.value);

  String getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'es':
        return 'Español';
      case 'fr':
        return 'Français';
      default:
        return 'English';
    }
  }

  String getLanguageFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇺🇸';
      case 'es':
        return '🇪🇸';
      case 'fr':
        return '🇫🇷';
      default:
        return '🇺🇸';
    }
  }

  /// Helper method to get translations (optional)
  AppLocalizations? get translations {
    final context = Get.context;
    return context != null ? AppLocalizations.of(context) : null;
  }

  /// Check if specific language is selected
  bool isLanguageSelected(Locale locale) => _locale.value == locale;
}