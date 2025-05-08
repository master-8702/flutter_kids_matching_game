import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/core/constants/setting_choices.dart';
import 'package:flutter_kids_matching_game/domain/states/settings_state.dart';
import 'package:flutter_kids_matching_game/data/local_settings_repository.dart';

// here we are declaring this notifier class in the domain folder rather than
// a presentation model is that: we coordinate multiple repository calls,
// it encapsulates logic about how and what to save... so it is more of
// a "use case" rather then a simple ui level notifier.

/// This is settings Notifier or settings controller class
class SettingsNotifier extends Notifier<SettingsState> {
  late final LocalSettingsRepository _repository;

// initializing our settings notifier
  @override
  SettingsState build() {
    _repository = ref.read(localSettingsRepositoryProvider);

    return SettingsState(
      selectedLanguage:
          AppLanguage.values.byName(_repository.getSelectedLanguage()),
      selectedLevel: GameLevel.values.byName(_repository.getSelectedLevel()),
      selectedThemeColor:
          ThemeColor.values.byName(_repository.getSelectedThemeColor()),
      selectedLocale: Locale(_repository.getSelectedLocale()),
    );
  }

  // setting app language
  Future<void> setLanguage(AppLanguage language) async {
    await _repository.setSelectedLanguage(language.actualName);
    await _repository.setSelectedLocale(language.languageCode);
    state = state.copyWith(
        selectedLanguage: language,
        selectedLocale: Locale(language.languageCode));
  }

  // setting game level
  Future<void> setLevel(GameLevel level) async {
    await _repository.setSelectedLevel(level.name);
    state = state.copyWith(selectedLevel: level);
  }

  // setting theme color
  Future<void> setThemeColor(ThemeColor color) async {
    await _repository.setSelectedThemeColor(color.name);
    await _repository.setSelectedThemeCode(color.code);
    state = state.copyWith(selectedThemeColor: color);
  }

  // resetting settings state
  Future<void> resetSettings() async {
    await _repository.resetSettings();
    state = const SettingsState(
      selectedLanguage: AppLanguage.english,
      selectedLevel: GameLevel.level1,
      selectedThemeColor: ThemeColor.pink,
      selectedLocale: Locale('en', 'US'),
    );
  }
}

// settings notifier (settings controller) provider
final settingsNotifierProvider =
    NotifierProvider<SettingsNotifier, SettingsState>(() {
  return SettingsNotifier();
});
