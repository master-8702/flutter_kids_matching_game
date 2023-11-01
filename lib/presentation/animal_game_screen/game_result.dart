import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/utilities/utilities.dart';
import 'package:flutter_kids_matching_game/presentation/animal_game_screen_controller.dart';

class GameResult extends ConsumerWidget {
  const GameResult({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalGameController = ref.watch(animalGameScreenControllerProvider);

    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          "${animalGameController.score}/60",
          style: const TextStyle(fontSize: 50),
        ),
        Text(
          AppLocalizations.of(context)!.gameOver,
          style: TextStyle(
              color:
                  animalGameController.score >= 50 ? Colors.green : Colors.red,
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
                  .read(animalGameScreenControllerProvider.notifier)
                  .initGame(context);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if ((animalGameController.score >= 50) &&
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
                await ref
                    .read(animalGameScreenControllerProvider.notifier)
                    .initGame(context);
              },
            ),
          )
      ],
    );
  }
}
