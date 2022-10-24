import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/provider/settings_provider.dart';
import 'package:flutter_kids_matching_game/screens/animal_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/color_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/fruit_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/game-list_screen.dart';
import 'package:flutter_kids_matching_game/screens/setting_page_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    final box = GetStorage();
    box.writeIfNull('selectedLanguage', 'English');
    box.writeIfNull('selectedLevel', 'Level 1');
    box.writeIfNull('selectedThemeColor', 'Pink');
    box.writeIfNull('selectedThemeCode', 0);
    box.writeIfNull('selectedLocale', 'en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SettingsProvider();
      },
      builder: (context, child) {
        final provider = Provider.of<SettingsProvider>(context);

        return MaterialApp(
          theme: ThemeData(
              fontFamily: 'Sunnyspells',
              colorScheme: ColorScheme(
                  primary: provider.themeColor as Color,
                  onError: Colors.red,
                  onBackground: Colors.white,
                  onSecondary: Colors.white,
                  error: Colors.red,
                  background: Colors.white,
                  onPrimary: Colors.white,
                  brightness: Brightness.light,
                  onSurface: Colors.black,
                  surface: Colors.grey,
                  secondary: provider.themeColor as Color),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(
                      fontSize: 40, fontStyle: FontStyle.italic),
                ),
              ),
              buttonTheme: const ButtonThemeData()),
          initialRoute: '/',
          routes: {
            '/': (context) => const GameListScreen(),
            '/colorGame': (context) => const ColorGameScreen(),
            '/animalGame': (context) => const AnimalGameScreen(),
            '/fruitGame': (context) => const FruitGameScreen(),
            '/setting': (context) => const SettingPageScreen(),
          },
          supportedLocales: L10n.all,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          locale: provider.local,
        );
      },
    );
  }
}
