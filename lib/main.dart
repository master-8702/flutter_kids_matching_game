import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/data/local_settings_repository.dart';
import 'package:flutter_kids_matching_game/presentation/animal_game_screen/animal_game_screen.dart';
import 'package:flutter_kids_matching_game/presentation/color_game_screen/color_game_screen.dart';
import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_game_screen.dart';
import 'package:flutter_kids_matching_game/presentation/settings_screen/settings_screen.dart';
import 'package:flutter_kids_matching_game/presentation/settings_screen_controller.dart';
import 'package:flutter_kids_matching_game/presentation/game-list_screen.dart';
import 'package:flutter_kids_matching_game/utilities/services/storage_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  // await GetStorage().erase();
  // WidgetsFlutterBinding.ensureInitialized(); is already called inside GetStorage.init()
  await StorageService().init();
  // await WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(
    child: EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('am', 'ET'),
        Locale('ar', 'SA')
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MyApp(),
    ),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(localSettingsRepositoryProvider).initValues();

    final con = ref.watch(settingsNotifierProvider);
    return MaterialApp(
        theme: ThemeData(
            fontFamily: 'Sunnyspells',
            colorScheme: ColorScheme(
              primary: con.themeColor,
              // primary: provider.themeColor as Color,
              onError: Colors.red,
              // onBackground: Colors.white,
              onSecondary: Colors.white,
              error: Colors.red,
              // background: Colors.white,
              onPrimary: Colors.white,
              brightness: Brightness.light,
              onSurface: Colors.black,
              surface: Colors.white,
              // surface: con.themeColor,

              secondary: con.themeColor,
            ),
            // secondary: provider.themeColor as Color),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: const TextStyle(
                  fontSize: 40,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            buttonTheme: const ButtonThemeData()),
        initialRoute: '/',
        routes: {
          '/': (context) => const GameListScreen(),
          // '/colorGame': (context) => const ColorGameScreen(),
          '/colorGame': (context) => ColorGameScreen(),
          '/animalGame': (context) => AnimalGameScreen(),
          '/fruitGame': (context) => FruitGameScreen(),
          // '/fruitGame': (context) => const FruitGameScreen(),
          '/setting': (context) => const SettingScreen(),
        },
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale);
  }
}
