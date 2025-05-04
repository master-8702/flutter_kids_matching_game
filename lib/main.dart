import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/theme/app_theme.dart';
import 'package:flutter_kids_matching_game/presentation/game-list_screen.dart';
import 'package:flutter_kids_matching_game/utilities/services/storage_service.dart';
import 'package:flutter_kids_matching_game/presentation/settings_screen_controller.dart';
import 'package:flutter_kids_matching_game/presentation/settings_screen/settings_screen.dart';
import 'package:flutter_kids_matching_game/presentation/color_game_screen/color_game_screen.dart';
import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_game_screen.dart';
import 'package:flutter_kids_matching_game/presentation/animal_game_screen/animal_game_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  await StorageService().init();

  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('am', 'ET'),
        Locale('ar', 'SA')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsNotifier = ref.watch(settingsNotifierProvider);
    final currentTheme = AppTheme.getThemeFor(settingsNotifier.themeColor);

    return MaterialApp(
        theme: currentTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => const GameListScreen(),
          '/colorGame': (context) => ColorGameScreen(),
          '/animalGame': (context) => AnimalGameScreen(),
          '/fruitGame': (context) => FruitGameScreen(),
          '/setting': (context) => const SettingScreen(),
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale);
  }
}
