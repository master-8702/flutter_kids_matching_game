import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/core/services/storage_service.dart';
import 'package:flutter_kids_matching_game/core/constants/local_storage_keys.dart';
import 'package:flutter_kids_matching_game/features/settings/domain/repositories/settings_repository.dart';

/// This is a local settings repository class that implements the
/// SettingsRepository interface. It uses the StorageService to persist
/// settings data locally.
class LocalSettingsRepository implements SettingsRepository {
  final StorageService _storage;

  LocalSettingsRepository(this._storage);

  Future<void> init() async => await _storage.init();

  // Setters
  @override
  Future<void> setSelectedLanguage(String languageName) async {
    _storage.write(kSelectedLanguageKey, languageName);
  }

  @override
  Future<void> setSelectedLevel(int gameLevel) async {
    _storage.write(kSelectedLevelKey, gameLevel);
  }

  @override
  Future<void> setSelectedThemeColor(String themeColorName) async {
    _storage.write(kSelectedThemeColorKey, themeColorName);
  }

  @override
  Future<void> setSelectedThemeCode(int themeColorCode) async {
    _storage.write(kSelectedThemeCodeKey, themeColorCode);
  }

  @override
  Future<void> setSelectedLocale(String localeCode) async {
    _storage.write(kSelectedLocaleKey, localeCode);
  }

  // resetters
  @override
  Future<void> resetSettings() async {
    await _storage.reset();
  }

  // Getters
  @override
  String getSelectedLanguage() {
    return _storage.read(kSelectedLanguageKey);
  }

  @override
  int getSelectedLevel() {
    return _storage.read(kSelectedLevelKey);
  }

  /// this method is used to get the next game level, it also sets the
  /// selected level to the next level in the local storage
  /// if the current level is 5, it will set the selected level to 1
  @override
  int getNextGameLevel() {
    final currentLevel = _storage.read(kSelectedLevelKey);
    switch (currentLevel) {
      case 1:
        setSelectedLevel(2);
        return 2;
      case 2:
        setSelectedLevel(3);
        return 3;
      case 3:
        setSelectedLevel(4);
        return 4;
      case 4:
        setSelectedLevel(5);
        return 5;
      default:
        setSelectedLevel(1);
        return 1;
    }
  }

  @override
  String getSelectedLocale() {
    return _storage.read(kSelectedLocaleKey);
  }

  @override
  int getSelectedThemeCode() {
    return _storage.read(kSelectedThemeCodeKey);
  }

  @override
  String getSelectedThemeColor() {
    return _storage.read((kSelectedThemeColorKey));
  }
}

final localSettingsRepositoryProvider =
    Provider<LocalSettingsRepository>((ref) {
  final storage = ref.watch(storageServicesProvider);
  return LocalSettingsRepository(storage);
});
