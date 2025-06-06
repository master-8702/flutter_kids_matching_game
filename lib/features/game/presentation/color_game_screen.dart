import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/theme/app_theme.dart';
import 'package:flutter_kids_matching_game/core/utilities/app_sizes.dart';
import 'package:flutter_kids_matching_game/core/constants/game_type.dart';
import 'package:flutter_kids_matching_game/core/constants/setting_choices.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/game_result.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/widgets/choice_a_draggable.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/widgets/choice_b_drag_target.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/game_screen_notifier.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_notifier.dart';

/// This widget is used to show the color game screen, where the user can
/// drag the left side names of colors and drop them on right side of the color
/// pictures.
class ColorGameScreen extends ConsumerStatefulWidget {
  const ColorGameScreen({Key? key}) : super(key: key);

  @override
  ColorGameScreenState createState() => ColorGameScreenState();
}

class ColorGameScreenState extends ConsumerState<ColorGameScreen> {
  late final AudioPlayer _audioController;

  // here we are calling initGame() to initialize choice lists based on the
  // selected game type and level.
  void _restartGame() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final level = ref.read(settingsNotifierProvider).selectedLevel;

      ref
          .read(gameScreenNotifierProvider.notifier)
          .initGame(currentLevel: level.number, gameType: GameType.color);
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
    final colorGameController = ref.watch(gameScreenNotifierProvider);
    final isGameOver = colorGameController.isGameOver;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${'score'.tr()} :  ${colorGameController.score}',
          style: const TextStyle(fontSize: 30),
        ),
      ),
      body: Container(
        decoration: !isGameOver
            // when the game screen is shown
            ? BoxDecoration(
                gradient: AppTheme.backgroundGradient(
                  primary: Colors.white,
                  secondary: AppTheme.primaryColor,
                ),
              )
            // when the result screen is shown
            : const BoxDecoration(
                color: AppTheme.backgroundColor,
                // color: Colors.white,
              ),
        child: Padding(
          padding: AppSizes.gameScreenMainPadding(context),
          child: Column(
            children: [
              if (!colorGameController.isGameOver)
                const Row(
                  children: <Widget>[
                    // left side choices with names
                    ChoiceA(),
                    Spacer(),
                    // right side choices with pictures
                    ChoiceB()
                  ],
                ),
              if (colorGameController.isGameOver)
                const Expanded(
                  child: GameResult(
                    gameType: GameType.color,
                  ),
                ),
            ],
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
