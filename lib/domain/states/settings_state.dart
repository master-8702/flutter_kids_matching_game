import 'dart:ui';

import 'package:flutter_kids_matching_game/constants/setting_choices.dart';

/// this class is our state class for the app settings
class SettingsState {
  final AppLanguage selectedLanguage;
  final GameLevel selectedLevel;
  final ThemeColor selectedThemeColor;
  final Locale selectedLocale;

  const SettingsState({
    required this.selectedLanguage,
    required this.selectedLevel,
    required this.selectedThemeColor,
    required this.selectedLocale,
  });

  SettingsState copyWith({
    AppLanguage? selectedLanguage,
    GameLevel? selectedLevel,
    ThemeColor? selectedThemeColor,
    Locale? selectedLocale,
  }) {
    return SettingsState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      selectedLevel: selectedLevel ?? this.selectedLevel,
      selectedThemeColor: selectedThemeColor ?? this.selectedThemeColor,
      selectedLocale: selectedLocale ?? this.selectedLocale,
    );
  }

// overriding equality operator for the state class
  @override
  bool operator ==(covariant SettingsState other) {
    if (identical(this, other)) return true;

    return other.selectedLanguage.languageCode ==
            selectedLanguage.languageCode &&
        other.selectedLevel.actualName == selectedLevel.actualName &&
        other.selectedThemeColor.code == selectedThemeColor.code &&
        other.selectedLocale.languageCode == selectedLocale.languageCode;
  }

  @override
  int get hashCode {
    return selectedLanguage.hashCode ^
        selectedLevel.hashCode ^
        selectedThemeColor.hashCode ^
        selectedLocale.hashCode;
  }
}
