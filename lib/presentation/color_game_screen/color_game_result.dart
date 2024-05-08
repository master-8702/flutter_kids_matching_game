import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_kids_matching_game/utilities/utilities.dart';
import 'package:flutter_kids_matching_game/presentation/color_game_screen/color_game_screen_controller.dart';
class ColorGameResult extends ConsumerWidget {
  const ColorGameResult({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorGameController = ref.watch(colorGameScreenControllerProvider);

    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          "${colorGameController.score}/60",
          style: const TextStyle(fontSize: 50),
        ),
        Text(
          AppLocalizations.of(context)!.gameOver,
          style: TextStyle(
              color:
                  colorGameController.score >= 50 ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 40),
        ),
        Center(
          child: ElevatedButton(
            child: Text(
              AppLocalizations.of(context)!.tryAgain, // style: TextStyle(
              //   fontSize: 30,
              // ),
            ),
            onPressed: () async {
              await ref
                  .read(colorGameScreenControllerProvider.notifier)
                  .initGame(context);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if ((colorGameController.score >= 50) &&
            Utilities().getGameLevel() <= 4)
          Center(
            child: ElevatedButton(
              child: Text(
                AppLocalizations.of(context)!.nextGame,
                // style: TextStyle(
                //   fontSize: 30,
                // ),
              ),
              onPressed: () async {
                Utilities().nextGameLevel();
                var temp = ref.read(colorGameScreenControllerProvider.notifier);
                await temp.initGame(context);
                
              },
            ),
          )
      ],
    );
  }
}
