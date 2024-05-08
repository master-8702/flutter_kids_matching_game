import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/utilities/utilities.dart';
import 'package:flutter_kids_matching_game/data/game_screen_state.dart';

class ColorGameScreenController extends AutoDisposeNotifier<GameScreenState> {
  @override
  GameScreenState build() {
    return const GameScreenState(
        score: 0, isGameOver: false, choiceA: [], choiceB: []);
  }

  // To initialize or restart the game
  // here when the initGame() is called from the UI, we will set the new state
  // with new  choices by also considering the current selected language,
  // since the context is also passed.
  Future<void> initGame(BuildContext context) async {
    final localization = AppLocalizations.of(context);

    final newChoiceAll = [
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
          level: localization.level5),
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

    final newChoiceA = List<GameItem>.from(newChoiceAll.where((element) =>
        element.level.contains(Utilities().getGameLevel().toString())));
    final newChoiceB = List<GameItem>.from(newChoiceA);
    newChoiceA.shuffle();
    newChoiceB.shuffle();
    // setting the new state based on the new choices
    state = state.copyWith(
        score: 0, isGameOver: false, choiceA: newChoiceA, choiceB: newChoiceB);
  }

  // will be called everytime when we answer (match) a question
  void removeAnsweredChoices(GameItem answeredItem) {
    state.choiceA.remove(answeredItem);
    state.choiceB.remove(answeredItem);
    if (state.choiceA.isEmpty || state.choiceB.isEmpty) {
      state = state.copyWith(isGameOver: true);
    }
  }

  // will be called when we match questions with answers correctly
  void scoreIncrement() {
    var tempScore = state.score;
    tempScore += 10;
    state = state.copyWith(score: tempScore);
  }

  // will be called when we match questions with answers incorrectly
  void scoreDecrement() {
    var tempScore = state.score;
    tempScore -= 5;
    state = state.copyWith(score: tempScore);
  }
}

// here we are declaring a global provider [NotifierProvider] to be exact, for
// our animalGameScreenController class
final colorGameScreenControllerProvider =
    AutoDisposeNotifierProvider<ColorGameScreenController, GameScreenState>(() {
  return ColorGameScreenController();
});
