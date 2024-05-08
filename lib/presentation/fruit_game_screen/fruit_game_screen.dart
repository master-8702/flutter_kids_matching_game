import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_game_screen_controller.dart';
import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_choice_a.dart';
import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_choice_b.dart';
import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_game_result.dart';


class FruitGameScreen extends ConsumerWidget {
  FruitGameScreen({Key? key}) : super(key: key);

  // we use it to play sounds
  final _audioController = AudioPlayer();
  var isFirstTime = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fruitGameController = ref.watch(fruitGameScreenControllerProvider);

// here we are calling initGame() to initialize choice lists inside a build method
// but only once, we will not call initGame() on every build method call.
// The reason is that the app implements localization features and support three
// languages, so the game choice at a certain point are different based on the
// selected language. and in order to display those language specific choices we
// need access to BuildContext, and the only place to get the BuildContext is the
// build method.
// I could also use ConsumerStatefulWidget and do that inside the initState(),
// but i think this one better for memory and performance since its stateless.
    if (isFirstTime) {
      ref.read(fruitGameScreenControllerProvider.notifier).initGame(context);
      isFirstTime = false;
    }

    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${localization!.score} :  ${fruitGameController.score}',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      // floating action button for restarting the game
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref
              .read(fruitGameScreenControllerProvider.notifier)
              .initGame(context);
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
                if (!fruitGameController.isGameOver)
                  Row(
                    children: <Widget>[
                      // left side choices with names
                      const FruitChoiceA(),
                      const Spacer(),
                      // right side choices with pictures
                      FruitChoiceB(
                        audioController: _audioController,
                      )
                    ],
                  ),
                if (fruitGameController.isGameOver) const FruitGameResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
