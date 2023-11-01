import 'package:flutter/widgets.dart';

class SettingState {
  final Locale locale;
  final Color themeColor;
  final String level;
  final String selectedLanguage;
  final int themeColorCode;

  SettingState({
    required this.locale,
    required this.themeColor,
    required this.level,
    required this.selectedLanguage,
    required this.themeColorCode,
  });

  SettingState copyWith({
    Locale? locale,
    Color? themeColor,
    String? level,
    String? selectedLanguage,
    int? themeColorCode,
  }) {
    return SettingState(
      locale: locale ?? this.locale,
      themeColor: themeColor ?? this.themeColor,
      level: level ?? this.level,
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      themeColorCode: themeColorCode ?? this.themeColorCode,
    );
  }

  @override
  bool operator ==(covariant SettingState other) {
    if (identical(this, other)) return true;

    return other.locale == locale && 
        other.themeColor == themeColor &&
        other.level == level &&
        other.selectedLanguage == selectedLanguage &&
        other.themeColorCode == themeColorCode;
  }

  @override
  int get hashCode {
    return locale.hashCode ^
        themeColor.hashCode ^
        level.hashCode ^
        selectedLanguage.hashCode ^
        themeColorCode.hashCode;
  }

  @override
  String toString() {
    return 'SettingState(locale: $locale, themeColor: $themeColor, level: $level, selectedLanguage: $selectedLanguage, themeColorCode: $themeColorCode)';
  }
}
