import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/constants/setting_choices.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/animal_game_screen/choice_a.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/animal_game_screen/choice_b.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/animal_game_screen/game_result.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/animal_game_screen_notifier.dart';

/// This widget is used to show the animal game screen
class AnimalGameScreen extends ConsumerStatefulWidget {
  const AnimalGameScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<AnimalGameScreen> createState() => _AnimalGameScreenState();
}

class _AnimalGameScreenState extends ConsumerState<AnimalGameScreen> {
  late final AudioPlayer _audioController;

  void _restartGame() {
    // here we are calling initGame() to initialize choice lists
    // and we are using WidgetsBinding to call the initGame() method
    // after the first frame is rendered.
    // this is because since we are updating the state inside initGame(), and it
    // is not recommended to update the state inside the lifecycle methods like
    // build method(yeah i know it is initState, but ) so we need to make sure
    // that the state is changed after the first frame is
    // rendered (build method finishes its first build).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final level = ref.read(settingsNotifierProvider).selectedLevel;

      ref
          .read(animalGameScreenNotifierProvider.notifier)
          .initGame(currentLevel: level.number);
    });
  }

  @override
  void initState() {
    super.initState();
    // here we are initializing the audio controller
    _audioController = AudioPlayer();

    // here we are calling restartGame(initGame) to initialize choice lists
    _restartGame();
  }

  @override
  void dispose() {
    // here we are disposing the audio controller
    _audioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animalGameController = ref.watch(animalGameScreenNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${'score'.tr()} :  ${animalGameController.score}',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      body: Material(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                if (!animalGameController.isGameOver)
                  Row(
                    children: <Widget>[
                      // left side choices with names
                      const ChoiceA(),
                      const Spacer(),
                      // right side choices with pictures
                      ChoiceB(
                        audioController: _audioController,
                      )
                    ],
                  ),
                if (animalGameController.isGameOver) const GameResult(),
              ],
            ),
          ),
        ),
      ),
      // floating action button for restarting the game
      floatingActionButton: FloatingActionButton(
        onPressed: _restartGame,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
