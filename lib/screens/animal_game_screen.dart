import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gameItems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/settings_provider.dart';

class AnimalGameScreen extends StatefulWidget {
  const AnimalGameScreen({Key? key}) : super(key: key);

  @override
  State<AnimalGameScreen> createState() => _AnimalGameScreenState();
}

class _AnimalGameScreenState extends State<AnimalGameScreen> {
  //to keep track of the player's score and game status

  // here new score
  late int score;
  late bool gameOver;

  late List<GameItem> choice_A;
  late List<GameItem> choice_B;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    initGame();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

//to initialize or restart the game

  void initGame() {
    final localization = AppLocalizations.of(context);

    score = 0;
    gameOver = false;

    choice_A = [
      GameItem(
        image: "assets/images/animals/Doe.png",
        name: localization!.doe,
        value: localization!.doe,
      ),
      GameItem(
          image: "assets/images/animals/Elephant.png",
          name: localization!.elephant,
          value: localization!.elephant),
      GameItem(
        image: "assets/images/animals/Ewe.png",
        name: localization!.ewe,
        value: localization!.ewe,
      ),
      GameItem(
          image: "assets/images/animals/Giraffe.png",
          name: localization!.giraffe,
          value: localization!.giraffe),
      GameItem(
        image: "assets/images/animals/Mule.png",
        name: localization!.mule,
        value: localization!.mule,
      ),
      GameItem(
          image: "assets/images/animals/Ostrich.png",
          name: localization!.ostrich,
          value: localization!.ostrich),
    ];

    choice_B = List<GameItem>.from(choice_A);

    choice_A.shuffle();
    choice_B.shuffle();
  }

  // we use it to play sounds
  final _audioController = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SettingsProvider>(context);
    if (choice_A.isEmpty) {
      gameOver = true;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('${AppLocalizations.of(context)!.score} :  $score'),
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
                // choice_A.shuffle(),
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
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      // GameLists(),
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
                              color: choice.accepting
                                  ? provider.themeColor
                                  : Colors.white,
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
                      Text(
                        AppLocalizations.of(context)!.gameOver,
                        style: const TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 40),
                      ),
                      Center(
                        child: ElevatedButton(
                          child: Text(
                            AppLocalizations.of(context)!
                                .tryAgain, // style: TextStyle(
                            //   fontSize: 30,
                            // ),
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
