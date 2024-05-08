import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/utilities/utilities.dart';
import 'package:flutter_kids_matching_game/data/game_screen_state.dart';

class FruitGameScreenController extends AutoDisposeNotifier<GameScreenState> {
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
final fruitGameScreenControllerProvider =
    AutoDisposeNotifierProvider<FruitGameScreenController, GameScreenState>(() {
  return FruitGameScreenController();
});
