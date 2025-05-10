import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

//  This file contains the constants for the settings choices that are
// used throughout the app. It defines the enums for game levels, app
// languages, and theme colors. Each enum has an extension that provides
// additional functionality such as getting translated names, actual names,
// color values, and locale values. This allows for easier management of
// settings in the app.

/// game level enum constant
enum GameLevel {
  level1,
  level2,
  level3,
  level4,
  level5,
}

extension GameLevelExtension on GameLevel {
  String get translatedName {
    switch (this) {
      case GameLevel.level1:
        return 'level1'.tr();
      case GameLevel.level2:
        return 'level2'.tr();
      case GameLevel.level3:
        return 'level3'.tr();
      case GameLevel.level4:
        return 'level4'.tr();
      case GameLevel.level5:
        return 'level5'.tr();
    }
  }

  String get actualName {
    switch (this) {
      case GameLevel.level1:
        return 'level1';
      case GameLevel.level2:
        return 'level2';
      case GameLevel.level3:
        return 'level3';
      case GameLevel.level4:
        return 'level4';
      case GameLevel.level5:
        return 'level5';
    }
  }

   int get number {
    switch (this) {
      case GameLevel.level1:
        return 1;
      case GameLevel.level2:
        return 2;
      case GameLevel.level3:
        return 3;
      case GameLevel.level4:
        return 4;
      case GameLevel.level5:
        return 5;
    }
  }
}

/// app supported languages enum constant
enum AppLanguage {
  english,
  amharic,
  arabic,
}

extension AppLanguageExtension on AppLanguage {
  String get translatedName {
    switch (this) {
      case AppLanguage.english:
        return 'english'.tr();
      case AppLanguage.amharic:
        return 'amharic'.tr();
      case AppLanguage.arabic:
        return 'arabic'.tr();
    }
  }

  String get actualName {
    switch (this) {
      case AppLanguage.english:
        return 'english';
      case AppLanguage.amharic:
        return 'amharic';
      case AppLanguage.arabic:
        return 'arabic';
    }
  }

  String get languageCode {
    switch (this) {
      case AppLanguage.english:
        return 'en';
      case AppLanguage.amharic:
        return 'am';
      case AppLanguage.arabic:
        return 'ar';
    }
  }

  Locale get locale {
    switch (this) {
      case AppLanguage.english:
        return const Locale('en', 'US');
      case AppLanguage.amharic:
        return const Locale('am', 'ET');
      case AppLanguage.arabic:
        return const Locale('ar', 'SA');
    }
  }
}

/// app theme color enum constant
enum ThemeColor { pink, purple, orange, green, red, grey }

extension ThemeColorExtension on ThemeColor {
  String get translatedName {
    switch (this) {
      case ThemeColor.pink:
        return 'pink'.tr();
      case ThemeColor.purple:
        return 'purple'.tr();
      case ThemeColor.orange:
        return 'orange_color'.tr();
      case ThemeColor.green:
        return 'green'.tr();
      case ThemeColor.red:
        return 'red'.tr();
      case ThemeColor.grey:
        return 'grey'.tr();
    }
  }

  String get actualName {
    switch (this) {
      case ThemeColor.pink:
        return 'pink';
      case ThemeColor.purple:
        return 'purple';
      case ThemeColor.orange:
        return 'orange';
      case ThemeColor.green:
        return 'green';
      case ThemeColor.red:
        return 'red';
      case ThemeColor.grey:
        return 'grey';
    }
  }

  Color get color {
    switch (this) {
      case ThemeColor.pink:
        return Colors.pink;
      case ThemeColor.purple:
        return Colors.deepPurple;
      case ThemeColor.orange:
        return Colors.deepOrange;
      case ThemeColor.green:
        return Colors.green;
      case ThemeColor.red:
        return Colors.red;
      case ThemeColor.grey:
        return Colors.black54;
    }
  }

  int get code {
    switch (this) {
      case ThemeColor.pink:
        return 0;
      case ThemeColor.purple:
        return 1;
      case ThemeColor.orange:
        return 2;
      case ThemeColor.green:
        return 3;
      case ThemeColor.red:
        return 4;
      case ThemeColor.grey:
        return 5;
    }
  }

  // to get the theme color name from (saved) theme color code (eg: 0 == pink )
  static ThemeColor fromCode(int code) {
    return ThemeColor.values.firstWhere((color) => color.code == code);
  }
}
