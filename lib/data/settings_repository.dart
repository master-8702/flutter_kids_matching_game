import 'package:flutter/material.dart';

abstract class SettingsRepository {
  String getSelectedLanguage();
  String getSelectedLevel();
  Color getSelectedThemeColor();
  String getSelectedThemeColorString();
  int getSelectedThemeCode();
  Locale getSelectedLocal();

  void setSelectedLanguage(String language);
  void setSelectedLevel(String level);
  void setSelectedThemeColor(Color themeColor);
  void setSelectedThemeColorString(String themeColor);

  void setSelectedThemeCode(int themeCode);
  void setSelectedLocal(Locale locale);
}
