import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/utilities/utilities.dart';
import 'package:flutter_kids_matching_game/data/animal_game_screen_state.dart';

class AnimalGameScreenController
    extends AutoDisposeNotifier<AnimalGameScreenState> {
  @override
  AnimalGameScreenState build() {
    return const AnimalGameScreenState(
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
final animalGameScreenControllerProvider = AutoDisposeNotifierProvider<
    AnimalGameScreenController, AnimalGameScreenState>(() {
  return AnimalGameScreenController();
});
