import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../models/gameItems.dart';

class FruitGameScreen extends StatefulWidget {
  const FruitGameScreen({Key? key}) : super(key: key);

  @override
  State<FruitGameScreen> createState() => _FruitGameScreenState();
}

class _FruitGameScreenState extends State<FruitGameScreen> {
  //to keep track of the player's score and game status

  // here new score
  late int score;
  late bool gameOver;

  late List<GameItem> choice_A;
  late List<GameItem> choice_B;

  @override
  void initState() {
    super.initState();

    initGame();
  }

//to initialize or restart the game

  void initGame() {
    score = 0;
    gameOver = false;

    choice_A = [
      GameItem(
          image: "assets/images/fruits/Apple.png",
          name: "Apple",
          value: "apple"),
      GameItem(
          image: "assets/images/fruits/Apricot.png",
          name: "Apricot",
          value: "apricot"),
      GameItem(
          image: "assets/images/fruits/Avocado.png",
          name: "Avocado",
          value: "avocado"),
      GameItem(
          image: "assets/images/fruits/Banana.png",
          name: "Banana",
          value: "banana"),
      GameItem(
          image: "assets/images/fruits/Blueberries.png",
          name: "Blueberries",
          value: "blueberries"),
      GameItem(
          image: "assets/images/fruits/Cherry.png",
          name: "Cherry",
          value: "cherry"),
    ];

    choice_B = List<GameItem>.from(choice_A);

    choice_A.shuffle();
    choice_B.shuffle();
  }

  // we use it to play sounds
  final _audioController = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    if (choice_A.isEmpty) {
      gameOver = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Score $score'),
        backgroundColor: Colors.pink,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initGame();
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      body: Material(
        child: Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (!gameOver)
                  Row(
                    children: <Widget>[
                      Column(
                        children: choice_A.map((choice) {
                          return Container(
                            margin: const EdgeInsets.all(8),
                            child: Draggable<GameItem>(
                              data: choice,
                              feedback: Text(
                                choice.name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                              childWhenDragging: Container(
                                padding: const EdgeInsets.all(12),
                                height: 80,
                                width: 150,
                                child: Text(
                                  choice.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                height: 80,
                                width: 150,
                                child: Text(
                                  choice.name,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 40,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const Spacer(),
                      Column(
                        children: choice_B.map((choice) {
                          return DragTarget<GameItem>(
                              onAccept: (receivedItem) async {
                            if (receivedItem.value == choice.value) {
                              await _audioController.play(
                                  AssetSource('sounds/success_bell2.mp3'));

                              // if (!mounted) return;
                              setState(() {
                                choice_A.remove(receivedItem);
                                choice_B.remove(choice);
                                score += 10;
                                choice.accepting = false;
                              });
                            } else {
                              setState(() {
                                score -= 5;
                                choice.accepting = false;
                              });
                            }
                          }, onLeave: (receivedItem) {
                            setState(() {
                              choice.accepting = false;
                            });
                          }, onWillAccept: (receivedItem) {
                            setState(() {
                              choice.accepting = true;
                            });
                            return true;
                          }, builder: (context, acceptedItem, rejectedItem) {
                            return Container(
                              color:
                                  choice.accepting ? Colors.red : Colors.white,
                              height: 80,
                              width: 105,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8),
                              child: Image.asset(
                                choice.image,
                              ),
                            );
                          });
                        }).toList(),
                      )
                    ],
                  ),
                if (gameOver)
                  Column(
                    children: [
                      Text(
                        "$score/60",
                        style: const TextStyle(fontSize: 50),
                      ),
                      const Text(
                        "GameOver",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                      Center(
                        child: ElevatedButton(
                          child: const Text(
                            "Try Again",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          onPressed: () {
                            initGame();
                            setState(() {});
                          },
                        ),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
