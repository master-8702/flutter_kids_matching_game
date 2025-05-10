import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/theme/app_theme.dart';
import 'package:flutter_kids_matching_game/core/utilities/app_spacing.dart';
import 'package:flutter_kids_matching_game/core/utilities/game_config.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_notifier.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/animal_game_screen_notifier.dart';

/// This widget is used to show the game result when the user finishes
/// a certain level
class GameResult extends ConsumerWidget {
  const GameResult({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalGameController = ref.watch(animalGameScreenNotifierProvider);
    final gameState = ref.watch(settingsNotifierProvider.notifier);

    return Column(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: 100,
        ),
        // here we are showing the score
        Center(
          child: Text(
            "${animalGameController.score}/${GameConfig.maxScore}",
            // style: const TextStyle(fontSize: 50),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        // 🧸 Game Over Message
        Center(
          child: Text(
            animalGameController.score >= GameConfig.passingScore
                ? 'you_win'.tr()
                : 'gameOver'.tr(),
            style: TextStyle(
                color: animalGameController.score >= GameConfig.passingScore
                    ? Colors.green
                    : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 40),
          ).tr(),
        ),
        AppSpacing.verticalSpaceLarge,

        // 🔁 Try Again Button
        ElevatedButton.icon(
          icon: const Icon(Icons.refresh),
          label: const Text(
            'tryAgain',
          ).tr(),
          style: AppTheme.elevatedButtonStyle(),
          onPressed: () async {
            await ref
                .read(animalGameScreenNotifierProvider.notifier)
                .initGame(currentLevel: gameState.getCurrentLevel());
          },
        ),
        const SizedBox(
          height: 15,
        ),
        // ➡️ Next Level Button (only if passed)
        // here we are checking if the score is greater than or equal to
        // the passing score and if the current level is less than the max level
        // if the above conditions are true then we will show the next level button
        if ((animalGameController.score >= GameConfig.passingScore) &&
            gameState.getCurrentLevel() < GameConfig.maxLevel)
          ElevatedButton.icon(
            iconAlignment: IconAlignment.end,
            icon: const Icon(Icons.arrow_forward),
            label: const Text(
              'nextGame',
            ).tr(),
            onPressed: () async {
              await ref
                  .read(animalGameScreenNotifierProvider.notifier)
                  .initGame(currentLevel: gameState.getNextGameLevel());
            },
          )
      ],
    );
  }
}
