import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import '../models/gameItems.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../provider/settings_provider.dart';

class ColorGameScreen extends StatefulWidget {
  const ColorGameScreen({Key? key}) : super(key: key);

  @override
  State<ColorGameScreen> createState() => _ColorGameScreenState();
}

class _ColorGameScreenState extends State<ColorGameScreen> {
  //to keep track of the player's score and game status

  // here new score
  late int score;
  late bool gameOver;

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
          image: "assets/images/colors/White.png",
          name: localization!.white,
          value: localization!.white,
          level: "Level 1"),
      GameItem(
          image: "assets/images/colors/Black.png",
          name: localization!.black,
          value: localization!.black,
          level: "Level 1"),
      GameItem(
          image: "assets/images/colors/Blue.png",
          name: localization!.blue,
          value: localization!.blue,
          level: "Level 1"),
      GameItem(
          image: "assets/images/colors/Red.png",
          name: localization!.red,
          value: localization!.red,
          level: "Level 1"),
      GameItem(
          image: "assets/images/colors/Green.png",
          name: localization!.green,
          value: localization!.green,
          level: "Level 1"),
      GameItem(
          image: "assets/images/colors/Yellow.png",
          name: localization!.yellow,
          value: localization!.yellow,
          level: "Level 1"),
      GameItem(
          image: "assets/images/colors/Orange.png",
          name: localization!.orange,
          value: localization!.orange,
          level: "Level 2"),
      GameItem(
          image: "assets/images/colors/Pink.png",
          name: localization!.pink,
          value: localization!.pink,
          level: "Level 2"),
      GameItem(
          image: "assets/images/colors/Purple.png",
          name: localization!.purple,
          value: localization!.purple,
          level: "Level 2"),
      GameItem(
          image: "assets/images/colors/Cyan.png",
          name: localization!.cyan,
          value: localization!.cyan,
          level: "Level 2"),
      GameItem(
          image: "assets/images/colors/Mustard.png",
          name: localization!.mustard,
          value: localization!.mustard,
          level: "Level 2"),
      GameItem(
          image: "assets/images/colors/Gray.png",
          name: localization!.gray,
          value: localization!.gray,
          level: "Level 2"),
      GameItem(
          image: "assets/images/colors/Navy Blue.png",
          name: localization!.navyblue,
          value: localization!.navyblue,
          level: "Level 3"),
      GameItem(
          image: "assets/images/colors/Golden.png",
          name: localization!.golden,
          value: localization!.golden,
          level: "Level 3"),
      GameItem(
          image: "assets/images/colors/Burgundy.png",
          name: localization!.burgundy,
          value: localization!.burgundy,
          level: "Level 3"),
      GameItem(
          image: "assets/images/colors/Lime.png",
          name: localization!.lime,
          value: localization!.lime,
          level: "Level 3"),
      GameItem(
          image: "assets/images/colors/Cream.png",
          name: localization!.cream,
          value: localization!.cream,
          level: "Level 3"),
      GameItem(
          image: "assets/images/colors/Aqua.png",
          name: localization!.aqua,
          value: localization!.aqua,
          level: "Level 3"),
      GameItem(
          image: "assets/images/colors/Beige.png",
          name: localization!.beige,
          value: localization!.beige,
          level: "Level 4"),
      GameItem(
          image: "assets/images/colors/Silver.png",
          name: localization!.silver,
          value: localization!.silver,
          level: "Level 4"),
      GameItem(
          image: "assets/images/colors/Olive.png",
          name: localization!.olive,
          value: localization!.olive,
          level: "Level 4"),
      GameItem(
          image: "assets/images/colors/Coral.png",
          name: localization!.coral,
          value: localization!.coral,
          level: "Level 4"),
      GameItem(
          image: "assets/images/colors/Mauve.png",
          name: localization!.mauve,
          value: localization!.mauve,
          level: "Level 4"),
      GameItem(
          image: "assets/images/colors/Teal.png",
          name: localization!.teal,
          value: localization!.teal,
          level: "Level 4"),
      GameItem(
          image: "assets/images/colors/Bronze.png",
          name: localization!.bronze,
          value: localization!.bronze,
          level: "Level 5"),
      GameItem(
          image: "assets/images/colors/Maroon.png",
          name: localization!.maroon,
          value: localization!.maroon,
          level: "Level 5"),
      GameItem(
          image: "assets/images/colors/Lavender.png",
          name: localization!.lavender,
          value: localization!.lavender,
          level: "Level 5"),
      GameItem(
          image: "assets/images/colors/Rust.png",
          name: localization!.rust,
          value: localization!.rust,
          level: "Level 5"),
      GameItem(
          image: "assets/images/colors/Peach.png",
          name: localization!.peach,
          value: localization!.peach,
          level: "Level 5"),
      GameItem(
          image: "assets/images/colors/Magenta.png",
          name: localization!.magenta,
          value: localization!.magenta,
          level: "Level 5"),
    ];
    // late String temp;
    // switch (tempLevel) {
    //   case "Level 1":
    //     temp = "";
    //     break;
    //   case "Level 2":
    //     i = 6;
    //     break;
    //   case "Level 3":
    //     i = 6;
    //     break;
    //   case "Level 4":
    //     i = 6;
    //     break;
    //   case "Level 5":
    //     i = 6;
    //     break;
    // }

    choice_A = List<GameItem>.from(choice_All.where(
        (element) => element.level == GetStorage().read('selectedLevel')));
    choice_B = List<GameItem>.from(choice_All.where(
        (element) => element.level == GetStorage().read('selectedLevel')));
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
                                  ? provider.themeColor as Color
                                  : Colors.white,
                              height: 80,
                              width: 105,
                              alignment: Alignment.center,
                              margin: const EdgeInsets.all(8),
                              child: Image.asset(choice.image),
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
                            AppLocalizations.of(context)!.tryAgain,
                            // style: TextStyle(
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
