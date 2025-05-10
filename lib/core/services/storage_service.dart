import 'package:get_storage/get_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/core/constants/local_storage_keys.dart';

/// This is a local storage service class that uses the GetStorage
/// package to persist data locally. It provides methods to read and write
/// data to the local storage. It also initializes the local storage
/// with default values if the app is opened for the first time or
/// has been cleared. The class is designed to be used with the
/// Riverpod state management library, allowing for easy access
/// and management of the local storage instance throughout the app.
class StorageService {
  late GetStorage _localStorage = GetStorage();

// instantiate the local storage if the app is opened for the first time
// or has been cleared
  Future<StorageService> init() async {
    _localStorage = GetStorage();
    await _localStorage.writeIfNull(kSelectedLanguageKey, 'english');
    await _localStorage.writeIfNull(kSelectedLevelKey, 1);
    await _localStorage.writeIfNull(kSelectedThemeColorKey, 'pink');
    await _localStorage.writeIfNull(kSelectedThemeCodeKey, 0);
    await _localStorage.writeIfNull(kSelectedLocaleKey, 'en');

    // returning the current GetStorage instance
    return this;
  }

// reading from the current get instance using key
  T read<T>(String key) {
    return _localStorage.read(key);
  }

// writing to the current get instance using key
  void write(String key, dynamic value) async {
    await _localStorage.write(key, value);
  }

  // erasing and re-initializing storages to reset the app
  Future<void> reset() async {
    await _localStorage.erase();
    await init();
  }
}

final storageServicesProvider = Provider<StorageService>((ref) {
  final storage = StorageService();
  storage.init();
  return storage;
});
