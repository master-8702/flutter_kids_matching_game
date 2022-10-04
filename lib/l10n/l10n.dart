import 'package:flutter/material.dart';

// the locales our app will support, and we will have translation files for those locales
class L10n {
  static final all = [
    const Locale('am'),
    const Locale('en'),
    const Locale('ar'),
  ];

  static String getLanguages(String code) {
    switch (code) {
      case 'am':
        return "አማርኛ";
      case 'en':
        return "English";
      case 'ar':
        return "العربية";
      default:
        return "English";
    }
  }
}
