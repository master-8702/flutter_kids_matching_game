import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../domain/game_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/settings_provider.dart';
import '../utilities/utilities.dart';

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
          image: "assets/images/fruits/apple.png",
          name: localization!.apple,
          value: localization!.apple,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/fruits/banana.png",
          name: localization.banana,
          value: localization.banana,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/fruits/strawberry.png",
          name: localization.strawberry,
          value: localization.strawberry,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/fruits/pineapple.png",
          name: localization.pineapple,
          value: localization.pineapple,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/fruits/orange.png",
          name: localization.orange,
          value: localization.orange,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/fruits/grapes.png",
          name: localization.grapes,
          value: localization.grapes,
          level: 'Level 1'),
      GameItem(
          image: "assets/images/fruits/avocado.png",
          name: localization.avocado,
          value: localization.avocado,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/fruits/apricot.png",
          name: localization.apricot,
          value: localization.apricot,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/fruits/blueberry.png",
          name: localization.blueberry,
          value: localization.blueberry,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/fruits/mango.png",
          name: localization.mango,
          value: localization.mango,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/fruits/pear.png",
          name: localization.pear,
          value: localization.pear,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/fruits/watermelon.png",
          name: localization.watermelon,
          value: localization.watermelon,
          level: 'Level 2'),
      GameItem(
          image: "assets/images/fruits/cactusfruit.png",
          name: localization.cactusfruit,
          value: localization.cactusfruit,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/fruits/cherry.png",
          name: localization.cherry,
          value: localization.cherry,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/fruits/guava.png",
          name: localization.guava,
          value: localization.guava,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/fruits/lemon.png",
          name: localization.lemon,
          value: localization.lemon,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/fruits/papaya.png",
          name: localization.papaya,
          value: localization.papaya,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/fruits/tangerine.png",
          name: localization.tangerine,
          value: localization.tangerine,
          level: 'Level 3'),
      GameItem(
          image: "assets/images/fruits/coconut.png",
          name: localization.coconut,
          value: localization.coconut,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/fruits/fig.png",
          name: localization.fig,
          value: localization.fig,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/fruits/citron.png",
          name: localization.citron,
          value: localization.citron,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/fruits/plum.png",
          name: localization.plum,
          value: localization.plum,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/fruits/soursop.png",
          name: localization.soursop,
          value: localization.soursop,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/fruits/whitesapote.png",
          name: localization.whitesapote,
          value: localization.whitesapote,
          level: 'Level 4'),
      GameItem(
          image: "assets/images/fruits/date.png",
          name: localization.date,
          value: localization.date,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/fruits/lychee.png",
          name: localization.lychee,
          value: localization.lychee,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/fruits/nectarine.png",
          name: localization.nectarine,
          value: localization.nectarine,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/fruits/passionfruit.png",
          name: localization.passionfruit,
          value: localization.passionfruit,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/fruits/peach.png",
          name: localization.peach,
          value: localization.peach,
          level: 'Level 5'),
      GameItem(
          image: "assets/images/fruits/pomegranate.png",
          name: localization.pomegranate,
          value: localization.pomegranate,
          level: 'Level 5')
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
                                height: 90,
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
                              height: 90,
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
                          // style: Theme.of(context).elevatedButtonTheme,
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
