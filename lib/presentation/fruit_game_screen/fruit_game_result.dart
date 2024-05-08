import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_kids_matching_game/utilities/utilities.dart';
import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_game_screen_controller.dart';

class FruitGameResult extends ConsumerWidget {
  const FruitGameResult({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fruitGameController = ref.watch(fruitGameScreenControllerProvider);

    return Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Text(
          "${fruitGameController.score}/60",
          style: const TextStyle(fontSize: 50),
        ),
        Text(
          AppLocalizations.of(context)!.gameOver,
          style: TextStyle(
              color:
                  fruitGameController.score >= 50 ? Colors.green : Colors.red,
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
                  .read(fruitGameScreenControllerProvider.notifier)
                  .initGame(context);
            },
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if ((fruitGameController.score >= 50) &&
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
                var temp = ref.read(fruitGameScreenControllerProvider.notifier);
                await temp.initGame(context);
              },
            ),
          )
      ],
    );
  }
}
