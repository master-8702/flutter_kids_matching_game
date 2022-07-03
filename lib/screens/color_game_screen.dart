import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ColorGameScreen extends StatefulWidget {
  const ColorGameScreen({Key? key}) : super(key: key);

  @override
  State<ColorGameScreen> createState() => _ColorGameScreenState();
}

class _ColorGameScreenState extends State<ColorGameScreen> {
  //map object to keep track of the player's score
  final Map<String, bool> score = {};

  //choices for the game
  final Map choices = {
    'green': Colors.green,
    'yellow': Colors.yellow,
    'red': Colors.red,
    'purple': Colors.purple,
    'brown': Colors.brown,
    'orange': Colors.orange,
  };

  //random seed to shuffle order of items
  int seed = 0;

  // we use it to play sounds
  final _audioController = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score ${score.length} / 6'),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
          });
        },
        child: Icon(Icons.refresh),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: choices.keys.map((colors) {
                return Draggable<String>(
                  data: colors,
                  feedback: ColorWidget(color: colors),
                  childWhenDragging: ColorWidget(
                    color: colors,
                  ),
                  child:
                      ColorWidget(color: score[colors] == true ? '✅' : colors),
                );
              }).toList()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                choices.keys.map((colors) => _buildDragTarget(colors)).toList()
                  ..shuffle(
                    (Random(seed)),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(color) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        if (score[color] == true) {
          return Container(
            color: Colors.white,
            child: Text(
              "Correct!",
              style: (TextStyle(fontSize: 30)),
            ),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        } else {
          return Container(
            color: choices[color],
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) {
        return data == color;
      },
      onAccept: (data) async {
        setState(() {
          score[color] = true;
        });
        // String url = 'assets/sounds/success_bell.mp3';
        // await _audioController.play(DeviceFileSource(url));
        // await _audioController.setSource(AssetSource('success_bell.mp3'));
        await _audioController.play(
          AssetSource('sounds/success_bell.mp3'),
        );
      },
      onLeave: (data) {},
    );
  }
}

class ColorWidget extends StatelessWidget {
  late final String color;

  ColorWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        alignment: Alignment.center,
        height: 100,
        padding: EdgeInsets.all(8),
        child: Text(
          color,
          style: TextStyle(color: Colors.black, fontSize: 50),
        ),
      ),
    );
  }
}
