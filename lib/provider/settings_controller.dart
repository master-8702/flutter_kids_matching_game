import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/data/settings_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/data/local_settings_repository.dart';
import 'package:flutter_kids_matching_game/l10n/l10n.dart';

class SettingsController extends Notifier<SettingState> {
  final localSettingsRepository = LocalSettingsRepository();

  @override
  build() {
    final settingsRepo = ref.watch(localSettingsRepositoryProvider);

    int themeColorCode = settingsRepo.getSelectedThemeCode();
    Locale locale = settingsRepo.getSelectedLocal();

    Color themColor = getSelectedThemeColor();
    String level = settingsRepo.getSelectedLevel();
    String selectedLanguage = settingsRepo.getSelectedLanguage();

    return SettingState(
        locale: locale,
        themeColor: themColor,
        level: level,
        selectedLanguage: selectedLanguage,
        themeColorCode: themeColorCode);
  }

  String getSelectedLanguage() {
    var selectedLanguage = localSettingsRepository.getSelectedLanguage();

    return selectedLanguage;
  }

  String getSelectedLevel() {
    var selectedLevel = localSettingsRepository.getSelectedLevel();

    return selectedLevel;
  }

  Color getSelectedThemeColor() {
    var selectedThemeCode = localSettingsRepository.getSelectedThemeCode();

    return _colorCodeToColor(selectedThemeCode);
  }

  String getSelectedThemeColorString() {
    var themeColorString = localSettingsRepository.getSelectedThemeCode();

    return _colorCodeToColorText(themeColorString);
  }

  int getSelectedThemeCode() {
    var selectedThemeCode = localSettingsRepository.getSelectedThemeCode();

    return selectedThemeCode;
  }

  // String getSelectedLocal() {
  //   _selectedLocale = _storageService.read(kSelectedLocaleKey);
  //   return _selectedLocale;
  // }

// setters for settings variables

  void setSelectedLanguage(String language) {
    localSettingsRepository.setSelectedLanguage(language);
    state = state.copyWith(selectedLanguage: language);

    final tempLang = localSettingsRepository.getSelectedLanguage();

    if (tempLang == 'አማርኛ') {
      // .setLocale(const Locale('am'));
      _changeLocal(const Locale('am'));
      localSettingsRepository.setSelectedLocal(const Locale('am'));
    } else if (tempLang == 'العربية') {
      // provider.setLocale(const Locale('ar'));
      _changeLocal(const Locale('ar'));
      localSettingsRepository.setSelectedLocal(const Locale('ar'));
    } else {
      // provider.setLocale(const Locale('en'));
      _changeLocal(const Locale('en'));
      localSettingsRepository.setSelectedLocal(const Locale('en'));
    }
  }

  void setSelectedLevel(String level) {
    localSettingsRepository.setSelectedLevel(level);
    state = state.copyWith(level: level);
  }

  Future<void> setSelectedThemeCode(int themeColorcode) async {
    localSettingsRepository.setSelectedThemeCode(themeColorcode);

    state = state.copyWith(
        themeColorCode: themeColorcode,
        themeColor:
            _colorCodeToColor(themeColorcode) // here is the solution to the bug
        );
  }

  void _changeLocal(Locale locale) {
    // here the condition is in case if the user selects from the phone's setting
    //a language we don't support, then we don't set the locale.
    if (!L10n.all.contains(locale)) return;

    state = state.copyWith(locale: locale);
  }

  Color _colorCodeToColor(int colorCode) {
    Color temp;
    switch (colorCode) {
      case 0:
        temp = Colors.pink;
        break;
      case 1:
        temp = Colors.purple;
        break;
      case 2:
        temp = Colors.orange;
        break;
      case 3:
        temp = Colors.green;
        break;
      default:
        temp = Colors.pink;
    }
    return temp;
  }

  String _colorCodeToColorText(int colorCode) {
    String temp;
    switch (colorCode) {
      case 0:
        temp = 'pink';
        break;
      case 1:
        temp = 'purple';
        break;
      case 2:
        temp = 'orange';
        break;
      case 3:
        temp = 'green';
        break;
      default:
        temp = 'pink';
    }
    return temp;
  }

  // int _colorStringToColorCode(String colorCodeString) {
  //   int temp;
  //   switch (colorCodeString) {
  //     case 'pink':
  //       temp = 0;
  //       break;
  //     case ('blue'): //  will check it later
  //       temp = 1;
  //       break;
  //     case 'orange':
  //       temp = 2;
  //       break;
  //     default:
  //       temp = 0;
  //   }
  //   return temp;
  // }
}

final settingsNotifierProvider =
    NotifierProvider<SettingsController, SettingState>(SettingsController.new);
