import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/utilities/constants/local_storage_keys.dart';
import 'package:flutter_kids_matching_game/data/settings_repository.dart';
import 'package:flutter_kids_matching_game/utilities/services/storage_service.dart';

class LocalSettingsRepository extends SettingsRepository {
  late String _selectedLanguage;// = _storageService.read(kSelectedLanguageKey);
  late String _selectedLevel;// = _storageService.read(kSelectedLevelKey);

  late int _selectedThemeCode;// = getSelectedThemeCode();
  late Locale _selectedLocale;
  // late String _selectedLanguage = _storageService.read(kSelectedLanguageKey);
  // late String _selectedLevel = _storageService.read(kSelectedLevelKey);
  // late Color _selectedThemeColor = getSelectedThemeColor();

  // late int _selectedThemeCode = getSelectedThemeCode();
  // late Locale _selectedLocale = _storageService.read(kSelectedLocaleKey);
  final _storageService = StorageService();

  void initValues() async {
    await _storageService.init();
    _selectedLanguage = getSelectedLanguage();
    _selectedLevel = getSelectedLevel();
    // _selectedThemeColor = _storageService.read(kSelectedThemeColorKey);
    _selectedThemeCode = getSelectedThemeCode();
    _selectedLocale = getSelectedLocal();
  }

// getters for settings variables
  @override
  String getSelectedLanguage() {
    _selectedLanguage = _storageService.read(kSelectedLanguageKey);

    return _selectedLanguage;
  }

  @override
  String getSelectedLevel() {
    _selectedLevel = _storageService.read(kSelectedLevelKey);

    return _selectedLevel;
  }

  @override
  int getSelectedThemeCode() {
    _selectedThemeCode = _storageService.read(kSelectedThemeCodeKey);

    return _selectedThemeCode;
  }

  @override
  Locale getSelectedLocal() {
    _selectedLocale = Locale(_storageService.read(kSelectedLocaleKey));
    return _selectedLocale;
  }

// setters for settings variables

  @override
  void setSelectedLanguage(String language) {
    _storageService.write(kSelectedLanguageKey, language);

    if (getSelectedLanguage() == 'አማርኛ') {
      // .setLocale(const Locale('am'));
      setSelectedLocal(const Locale('am'));
    } else if (getSelectedLanguage() == 'العربية') {
      // provider.setLocale(const Locale('ar'));
      setSelectedLocal(const Locale('ar'));
    } else {
      // provider.setLocale(const Locale('en'));
      setSelectedLocal(const Locale('en'));
    }
  }

  @override
  void setSelectedLevel(String level) {
    _storageService.write(kSelectedLevelKey, level);
  }

  @override
  void setSelectedThemeCode(int themeCode) {
    _storageService.write(kSelectedThemeCodeKey, themeCode);
  }

  @override
  void setSelectedLocal(Locale locale) {
    _storageService.write(kSelectedLocaleKey, locale.toString());
  }
}

final localSettingsRepositoryProvider =
    Provider<LocalSettingsRepository>((ref) {
  return LocalSettingsRepository();
});
