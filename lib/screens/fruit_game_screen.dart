import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

class FruitGameScreen extends StatefulWidget {
  const FruitGameScreen({Key? key}) : super(key: key);

  @override
  State<FruitGameScreen> createState() => _FruitGameScreenState();
}

class _FruitGameScreenState extends State<FruitGameScreen> {
  //map object to keep track of the player's score
  final Map<String, bool> score = {};

  final Map questionChoices = {
    'banana': '🍌',
    'orange': '🍊',
    'apple': '🍎',
    'strawberry': '🍓',
    'avocado': '🥑',
    'pineapple': '🍍',
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
              children: questionChoices.keys.map((fruitName) {
                return Draggable<String>(
                  data: fruitName,
                  feedback: FruitWidget(color: fruitName),
                  childWhenDragging: FruitWidget(
                    color: fruitName,
                  ),
                  child: FruitWidget(
                      color: score[fruitName] == true ? '✅' : fruitName),
                );
              }).toList()),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: questionChoices.keys
                .map((fruitIcon) => _buildDragTarget(fruitIcon))
                .toList()
              ..shuffle(
                (Random(seed)),
              ),
          ),
        ],
      ),
    );
  }

  Widget _buildDragTarget(fruitIcon) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        if (score[fruitIcon] == true) {
          return Container(
            color: Colors.white,
            child: Text(
              "Correct!",
              style: (TextStyle(fontSize: 30)),
            ),
            alignment: Alignment.center,
            height: 80,
            width: 180,
          );
        } else {
          return Container(
            child: Text(
              questionChoices[fruitIcon],
              style: TextStyle(fontSize: 60),
            ),
            alignment: Alignment.center,
            height: 80,
            width: 180,
          );
        }
      },
      onWillAccept: (data) {
        return data == fruitIcon;
      },
      onAccept: (data) async {
        setState(() {
          score[fruitIcon] = true;
        });

        await _audioController.play(
          AssetSource('sounds/success_bell.mp3'),
        );
      },
      onLeave: (data) {},
    );
  }
}

class FruitWidget extends StatelessWidget {
  late final String color;

  FruitWidget({required this.color});

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
          style: TextStyle(color: Colors.black, fontSize: 40),
        ),
      ),
    );
  }
}
