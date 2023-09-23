import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/constants/local_storage_keys.dart';
import 'package:flutter_kids_matching_game/data/settings_repository.dart';
import 'package:flutter_kids_matching_game/services/storage_service.dart';

class LocalSettingsRepository extends SettingsRepository {
  late String _selectedLanguage = _storageService.read(kSelectedLanguageKey);
  late String _selectedLevel = _storageService.read(kSelectedLevelKey);
  late Color _selectedThemeColor = getSelectedThemeColor();

  late int _selectedThemeCode = getSelectedThemeCode();
  late Locale _selectedLocale = _storageService.read(kSelectedLocaleKey);
  final _storageService = StorageService();

  void initValues() async {
    await _storageService.init();
    _selectedLanguage = _storageService.read(kSelectedLanguageKey);
    _selectedLevel = _storageService.read(kSelectedLevelKey);
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
  Color getSelectedThemeColor() {
    // _selectedThemeColor = _storageService.read(kSelectedThemeColorKey);
    var themeColorCode = getSelectedThemeCode();
    _selectedThemeColor = themeColorCode == 0
        ? Colors.pinkAccent
        : themeColorCode == 1
            ? Colors.purpleAccent
            : Colors.orangeAccent;

    return _selectedThemeColor;
  }

  @override
  String getSelectedThemeColorString() {
    // TODO: implement getSelectedThemeColorString
    throw UnimplementedError();
  }

  @override
  int getSelectedThemeCode() {
    var ab = _storageService.read(kSelectedThemeCodeKey);
    print(ab.runtimeType);
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
  void setSelectedThemeColor(Color themeColor) {
    _storageService.write(kSelectedThemeColorKey, themeColor);
  }

  @override
  void setSelectedThemeCode(int themeCode) {
    _storageService.write(kSelectedThemeCodeKey, themeCode);
  }

  @override
  void setSelectedLocal(Locale locale) {
    _storageService.write(kSelectedLocaleKey, locale.toString());
  }

  @override
  void setSelectedThemeColorString(String themeColor) {
    _storageService.write(kSelectedThemeColorStringKey, themeColor);
  }
}

final localSettingsRepositoryProvider =
    Provider<LocalSettingsRepository>((ref) {
  return LocalSettingsRepository();
});
