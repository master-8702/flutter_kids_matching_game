import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/screens/animal_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/color_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/fruit_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/game-list_screen.dart';
import 'package:flutter_kids_matching_game/screens/setting_page_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Sunnyspells',
          colorScheme: const ColorScheme(
              primary: Colors.pinkAccent,
              onError: Colors.red,
              onBackground: Colors.white,
              onSecondary: Colors.white,
              error: Colors.red,
              background: Colors.white,
              onPrimary: Colors.white,
              brightness: Brightness.light,
              onSurface: Colors.black,
              surface: Colors.grey,
              secondary: Colors.pink),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 10,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle:
                    const TextStyle(fontSize: 40, fontStyle: FontStyle.italic),
                primary: Colors.pink),
          ),
          buttonTheme: ButtonThemeData()),
      initialRoute: '/',
      routes: {
        '/': (context) => GameListScreen(),
        '/colorGame': (context) => ColorGameScreen(),
        '/animalGame': (context) => AnimalGameScreen(),
        '/fruitGame': (context) => FruitGameScreen(),
        '/setting': (context) => SettingPageScreen(),
      },
    );
  }
}
