import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/services/storage_service.dart';
import 'package:flutter_kids_matching_game/core/constants/local_storage_keys.dart';
import 'package:flutter_kids_matching_game/domain/repositories/settings_repository.dart';

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
  Future<void> setSelectedLevel(String gameLevel) async {
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
  String getSelectedLevel() {
    return _storage.read(kSelectedLevelKey);
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
