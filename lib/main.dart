import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_kids_matching_game/screens/animal_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/color_game_screen.dart';
import 'package:flutter_kids_matching_game/screens/game-list_screen.dart';

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
      theme: ThemeData(fontFamily: 'Sunnyspells'),
      initialRoute: '/',
      routes: {
        '/': (context) => GameListScreen(),
        '/colorGame': (context) => ColorGameScreen(),
        '/animalGame': (context) => AnimalGameScreen(),
      },
    );
  }
}
