/// an abstract class for our settings repository
abstract class SettingsRepository {
  String getSelectedLanguage();
  int getSelectedLevel();
  int getNextGameLevel();
  int getSelectedThemeCode();
  String getSelectedThemeColor();
  String getSelectedLocale();
  void resetSettings();

  void setSelectedLanguage(String languageName);
  void setSelectedLevel(int gameLevel);
  void setSelectedThemeCode(int themeColorName);
  void setSelectedThemeColor(String themeColorCode);
  void setSelectedLocale(String localeCode);
}
