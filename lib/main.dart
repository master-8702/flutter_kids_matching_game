import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/data/local_settings_repository.dart';
import 'package:flutter_kids_matching_game/presentation/animal_game_screen/animal_game_screen.dart';
import 'package:flutter_kids_matching_game/presentation/settings_screen/settings_screen.dart';
import 'package:flutter_kids_matching_game/presentation/settings_screen_controller.dart';
import 'package:flutter_kids_matching_game/screens/color_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/fruit_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/game-list_screen.dart';
import 'package:flutter_kids_matching_game/services/storage_service.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await GetStorage.init();
  // await GetStorage().erase();
  // WidgetsFlutterBinding.ensureInitialized(); is already called inside GetStorage.init()
  await StorageService().init();
  // await WidgetsFlutterBinding.ensureInitialized();

  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
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
            onBackground: Colors.white,
            onSecondary: Colors.white,
            error: Colors.red,
            background: Colors.white,
            onPrimary: Colors.white,
            brightness: Brightness.light,
            onSurface: Colors.black,
            surface: Colors.grey,

            secondary: con.themeColor,
          ),
          // secondary: provider.themeColor as Color),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              elevation: 10,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              textStyle:
                  const TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
            ),
          ),
          buttonTheme: const ButtonThemeData()),
      initialRoute: '/',
      routes: {
        '/': (context) => const GameListScreen(),
        '/colorGame': (context) => const ColorGameScreen(),
        '/animalGame': (context) => AnimalGameScreen(),
        '/fruitGame': (context) => const FruitGameScreen(),
        '/setting': (context) => const SettingScreen(),
      },
      supportedLocales: L10n.all,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      locale: con.locale,
      // locale: provider.local,
    );
  }
}
