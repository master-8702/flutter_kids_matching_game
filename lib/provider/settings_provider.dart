import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import 'package:flutter_kids_matching_game/l10n/l10n.dart';

class SettingsProvider extends ChangeNotifier {
  Locale _selectedLocale = GetStorage().read('selectedLocale');

  final int _colorCode = GetStorage().read('selectedThemeCode');
  late Color _themColor = _colorCode == 0
      ? Colors.pinkAccent
      : _colorCode == 1
          ? Colors.purpleAccent
          : Colors.orangeAccent;

  // then we will define getter and setter for the (selected)language
  Locale? get local {
    return _selectedLocale;
  }

  // to set a new local language
  void setLocale(Locale locale) {
    // here the condition is in case if the user selects from the phone's setting a language we don't support, then we don't set the locale.

    if (!L10n.all.contains(locale)) return;
    _selectedLocale = locale;
    notifyListeners();
  }

// to clear the setted language
  void clearLocale() {
    _selectedLocale = const Locale('en');
    notifyListeners();
  }

  // setter and getter for theme color
  Color? get themeColor {
    return _themColor;
  }

  void setTheme(int colorCode) {
    if (colorCode == 0) {
      _themColor = Colors.pinkAccent;
    } else if (colorCode == 1) {
      _themColor = Colors.purpleAccent;
    } else {
      _themColor = Colors.orangeAccent;
    }
  }
}
