import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/screens/color_game_screen.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/colorGame');
              },
              child: Text("Color Game"),
            ),
            TextButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/animalGame');
              },
              child: Text("Animal Game"),
            )
          ],
        ),
      ),
    );
  }
}
