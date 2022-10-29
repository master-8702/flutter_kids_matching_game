import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/gameItems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/settings_provider.dart';
import '../utilities/utilities.dart';

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
  late Utilities utilities = Utilities();

  late List<GameItem> choice_All;
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

    choice_All = [
      GameItem(
          image: "assets/images/animals/sheep.png",
          name: localization!.sheep,
          value: localization!.sheep,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/animals/lion.png",
          name: localization!.lion,
          value: localization!.lion,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/animals/elephant.png",
          name: localization!.elephant,
          value: localization!.elephant,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/animals/ostrich.png",
          name: localization!.ostrich,
          value: localization!.ostrich,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/animals/giraffe.png",
          name: localization!.giraffe,
          value: localization!.giraffe,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/animals/camel.png",
          name: localization!.camel,
          value: localization!.camel,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/animals/chicken.png",
          name: localization!.chicken,
          value: localization!.chicken,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/animals/leopard.png",
          name: localization!.leopard,
          value: localization!.leopard,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/animals/monkey.png",
          name: localization!.monkey,
          value: localization!.monkey,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/animals/zebra.png",
          name: localization!.zebra,
          value: localization!.zebra,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/animals/owl.png",
          name: localization!.owl,
          value: localization!.owl,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/animals/tiger.png",
          name: localization!.tiger,
          value: localization!.tiger,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/animals/ox.png",
          name: localization!.ox,
          value: localization!.ox,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/animals/squirrel.png",
          name: localization!.squirrel,
          value: localization!.squirrel,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/animals/mouse.png",
          name: localization!.mouse,
          value: localization!.mouse,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/animals/gorilla.png",
          name: localization!.gorilla,
          value: localization!.gorilla,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/animals/chimpanzee.png",
          name: localization!.chimpanzee,
          value: localization!.chimpanzee,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/animals/buffalo.png",
          name: localization!.buffalo,
          value: localization!.buffalo,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/animals/cheetah.png",
          name: localization!.cheetah,
          value: localization!.cheetah,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/animals/crocodile.png",
          name: localization!.crocodile,
          value: localization!.crocodile,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/animals/duck.png",
          name: localization!.duck,
          value: localization!.duck,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/animals/fox.png",
          name: localization!.fox,
          value: localization!.fox,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/animals/hippopotamus.png",
          name: localization!.hippopotamus,
          value: localization!.hippopotamus,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/animals/mule.png",
          name: localization!.mule,
          value: localization!.mule,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/animals/horse.png",
          name: localization!.horse,
          value: localization.horse,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/animals/kangaroo.png",
          name: localization.kangaroo,
          value: localization.kangaroo,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/animals/deer.png",
          name: localization.deer,
          value: localization.deer,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/animals/panter.png",
          name: localization.panter,
          value: localization.panter,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/animals/penguin.png",
          name: localization.penguin,
          value: localization.penguin,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/animals/rhinoceros.png",
          name: localization.rhinoceros,
          value: localization.rhinoceros,
          level: 'Level 5'),
    ];

    choice_A = List<GameItem>.from(choice_All.where((element) =>
        element.level.contains(utilities.getGameLevel().toString())));
    choice_B = List<GameItem>.from(choice_All.where((element) =>
        element.level.contains(utilities.getGameLevel().toString())));
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
        title: Text(
          '${AppLocalizations.of(context)!.score} :  $score',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          initGame();
          setState(() {});
        },
        child: const Icon(Icons.refresh),
      ),
      body: Material(
        child: SingleChildScrollView(
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
                      const SizedBox(
                        height: 100,
                      ),
                      Text(
                        "$score/60",
                        style: const TextStyle(fontSize: 50),
                      ),
                      Text(
                        AppLocalizations.of(context)!.gameOver,
                        style: TextStyle(
                            color: score >= 50 ? Colors.green : Colors.red,
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
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      if ((score >= 50) && utilities.getGameLevel() <= 4)
                        Center(
                          child: ElevatedButton(
                            child: Text(
                              AppLocalizations.of(context)!.nextGame,
                              // style: TextStyle(
                              //   fontSize: 30,
                              // ),
                            ),
                            onPressed: () {
                              utilities.nextGameLevel();
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
