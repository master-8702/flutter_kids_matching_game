import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/l10n/l10n.dart';

class LocalProvider extends ChangeNotifier {
  late Locale? _local =
      Locale('am'); // to store the selected locale or language;

  // then we will define getter and setter for the (selected)language
  Locale? get local => _local;
  void setLocale(Locale locale) {
    // here the condition is in case if the user selects from the phone's setting a language we don't support, then we don't set the locale.

    if (!L10n.all.contains(locale)) return;
    _local = locale;
    notifyListeners();
  }

  void clearLocale() {
    _local = null;
    notifyListeners();
  }
}
