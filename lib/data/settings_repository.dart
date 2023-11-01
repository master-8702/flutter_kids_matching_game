import 'package:flutter/material.dart';

abstract class SettingsRepository {
  String getSelectedLanguage();
  String getSelectedLevel();
  int getSelectedThemeCode();
  Locale getSelectedLocal();

  void setSelectedLanguage(String language);
  void setSelectedLevel(String level);
  void setSelectedThemeCode(int themeCode);
  void setSelectedLocal(Locale locale);
}
