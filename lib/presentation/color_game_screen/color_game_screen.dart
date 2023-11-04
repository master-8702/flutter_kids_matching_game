import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_kids_matching_game/presentation/color_game_screen_controller.dart';
import 'package:flutter_kids_matching_game/presentation/color_game_screen/color_choice_a.dart';
import 'package:flutter_kids_matching_game/presentation/color_game_screen/color_choice_b.dart';
import 'package:flutter_kids_matching_game/presentation/color_game_screen/color_game_result.dart';

class ColorGameScreen extends ConsumerWidget {
  ColorGameScreen({Key? key}) : super(key: key);

  // we use it to play sounds
  final _audioController = AudioPlayer();
  var isFirstTime = true;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorGameController = ref.watch(colorGameScreenControllerProvider);

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
      ref.read(colorGameScreenControllerProvider.notifier).initGame(context);
      isFirstTime = false;
    }

    final localization = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${localization!.score} :  ${colorGameController.score}',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      // floating action button for restarting the game
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ref
              .read(colorGameScreenControllerProvider.notifier)
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
                if (!colorGameController.isGameOver)
                  Row(
                    children: <Widget>[
                      // left side choices with names
                      const ColorChoiceA(),
                      const Spacer(),
                      // right side choices with pictures
                      ColorChoiceB(
                        audioController: _audioController,
                      )
                    ],
                  ),
                if (colorGameController.isGameOver) const ColorGameResult(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
