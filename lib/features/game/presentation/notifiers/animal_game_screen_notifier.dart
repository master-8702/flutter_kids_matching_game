import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/core/utilities/game_utils.dart';
import 'package:flutter_kids_matching_game/core/utilities/game_config.dart';
import 'package:flutter_kids_matching_game/features/game/data/game_data.dart';
import 'package:flutter_kids_matching_game/features/game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/game_screen_state.dart';

/// This is the notifier (controller) class for the animal game screen.
class AnimalGameScreenNotifier extends AutoDisposeNotifier<GameScreenState> {
  @override
  GameScreenState build() {
    // here we are initializing the state with default values
    return const GameScreenState(
        score: 0, isGameOver: false, choiceA: [], choiceB: []);
  }

  // To initialize or restart the game
  // here when the initGame() is called from the UI, we will set the new state
  // with new  choices and score.
  Future<void> initGame({required int currentLevel}) async {
    // here we are getting the current level choices from the game data
    // and filtering the items based on the current level.
    final filteredItems =
        GameData.animals.where((item) => item.level == currentLevel).toList();

    // here we are assigning the filtered items to choiceA and choiceB
    // and shuffling them to get random choices.
    // we are using '..' the cascade operator here to call the shuffle() method
    final choiceA = List<GameItem>.from(filteredItems)..shuffle();
    final choiceB = List<GameItem>.from(filteredItems)..shuffle();

    // setting the new state based on the new choices
    state = state.copyWith(
        score: 0, isGameOver: false, choiceA: choiceA, choiceB: choiceB);
  }

  // will be called every time when we answer (match) a question
  void removeAnsweredChoices(GameItem answeredItem) {
    final updatedA =
        GameUtils.removeMatchedItemFromList(state.choiceA, answeredItem);
    final updatedB =
        GameUtils.removeMatchedItemFromList(state.choiceB, answeredItem);

    state = state.copyWith(choiceA: updatedA, choiceB: updatedB);

    // if one of the lists is empty, we will set the game over state to true
    // and show the game over dialog
    if (updatedA.isEmpty || updatedB.isEmpty) {
      state = state.copyWith(isGameOver: true);
    }
  }

  // will be called when we match questions with answers correctly
  void scoreIncrement() {
    state = state.copyWith(score: state.score + GameConfig.correctMatchScore);
  }

  // will be called when we match questions with answers incorrectly
  void scoreDecrement() {
    state = state.copyWith(score: state.score - GameConfig.wrongMatchScore);
  }
}

// here we are declaring a global provider [NotifierProvider] to be exact, for
// our animalGameScreenNotifier class
final animalGameScreenNotifierProvider =
    AutoDisposeNotifierProvider<AnimalGameScreenNotifier, GameScreenState>(() {
  return AnimalGameScreenNotifier();
});
