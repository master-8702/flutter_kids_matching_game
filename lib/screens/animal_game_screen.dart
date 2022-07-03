import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AnimalGameScreen extends StatefulWidget {
  const AnimalGameScreen({Key? key}) : super(key: key);

  @override
  State<AnimalGameScreen> createState() => _AnimalGameScreenState();
}

class _AnimalGameScreenState extends State<AnimalGameScreen> {
  //map object to keep track of the player's score
  final Map<String, bool> score = {};

  //choices for the game
  // final Map questionChoices = {
  //   'cat': '🐘',
  //   'dog': '🐘',
  //   'horse': '🐘',
  //   'cow': '🐘',
  //   'bird': '🐘',
  //   'sheep': '🐘',
  // };

  final Map questionChoices = {
    'cat': '🐱',
    'dog': '🐶',
    'horse': '🐎',
    'cow': '🐮',
    'bird': '🐦',
    'sheep': '🐑',
  };

  final Map answerChoices = {
    'cat': '🐱',
    'dog': '🐶',
    'horse': '🐎',
    'cow': '🐮',
    'bird': '🐦',
    'sheep': '🐑',
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: questionChoices.keys.map((animalName) {
                return Draggable<String>(
                  data: animalName,
                  feedback: AnimalWidget(color: animalName),
                  childWhenDragging: AnimalWidget(
                    color: animalName,
                  ),
                  child: AnimalWidget(
                      color: score[animalName] == true ? '✅' : animalName),
                );
              }).toList()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: questionChoices.keys
                .map((animalIcon) => _buildDragTarget(animalIcon))
                .toList()
              ..shuffle(
                (Random(seed)),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(animalIcon) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        if (score[animalIcon] == true) {
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
            child: Text(
              questionChoices[animalIcon],
              style: TextStyle(fontSize: 60),
            ),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) {
        return data == animalIcon;
      },
      onAccept: (data) async {
        setState(() {
          score[animalIcon] = true;
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

class AnimalWidget extends StatelessWidget {
  late final String color;

  AnimalWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        // alignment: Alignment.center,
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
