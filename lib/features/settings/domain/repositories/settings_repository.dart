/// an abstract class for our settings repository
abstract class SettingsRepository {
  String getSelectedLanguage();
  String getSelectedLevel();
  int getSelectedThemeCode();
  String getSelectedThemeColor();
  String getSelectedLocale();
  void resetSettings();

  void setSelectedLanguage(String languageName);
  void setSelectedLevel(String gameLevel);
  void setSelectedThemeCode(int themeColorName);
  void setSelectedThemeColor(String themeColorCode);
  void setSelectedLocale(String localeCode);
}
