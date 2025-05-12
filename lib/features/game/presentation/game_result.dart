import 'dart:math';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/theme/app_theme.dart';
import 'package:flutter_kids_matching_game/core/constants/game_type.dart';
import 'package:flutter_kids_matching_game/core/utilities/app_spacing.dart';
import 'package:flutter_kids_matching_game/core/utilities/game_config.dart';
import 'package:flutter_kids_matching_game/core/constants/setting_choices.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/overlapped_game_icons.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/game_screen_state.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_state.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/game_screen_notifier.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_notifier.dart';

/// This widget is used to show the game result when the user finishes
/// a certain level
class GameResult extends ConsumerStatefulWidget {
  final GameType gameType;

  const GameResult({super.key, required this.gameType});

  @override
  ConsumerState<GameResult> createState() => _GameResultState();
}

class _GameResultState extends ConsumerState<GameResult>
    with SingleTickerProviderStateMixin {
  // Required for animations
  // Animation controller manages the animation timeline
  late AnimationController _controller;
  // Scale animation for the score display
  late Animation<double> _scoreScale;
  // Slide animation for the result message
  late Animation<Offset> _messageOffset;
  // Fade animation for buttons
  late Animation<double> _buttonOpacity;
  @override
  void initState() {
    super.initState();
    // Initialize animation controller with 3-second duration
    _controller = AnimationController(
      vsync: this, // Ticker provider from SingleTickerProviderStateMixin
      duration: const Duration(seconds: 3),
    );

    // Score scale animation configuration:
    // - Scales from 20% size to 110% size
    // - Uses elasticOut curve for bounce effect
    // - Runs in first half of animation timeline (0.0-0.5 interval)
    _scoreScale = Tween<double>(begin: 0.2, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.elasticOut),
      ),
    );

    // Message slide animation configuration:
    // - Slides from bottom (Offset(0, 0.5) to center
    // - Uses easeOutBack curve for smooth overshoot effect
    // - Runs through full animation timeline (0.0-1.0 interval)
    _messageOffset = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 1.0, curve: Curves.easeOutBack),
    ));

    // Button opacity animation configuration:
    // - Fades from invisible (0) to fully visible (1)
    // - Uses easeIn curve for smooth entrance
    // - Runs in second half of animation timeline (0.5-1.0 interval)
    _buttonOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    // Start the animation sequence
    _controller.forward();
  }

  @override
  void dispose() {
    // Clean up animation controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gameState = ref.watch(gameScreenNotifierProvider);
    final settingsState = ref.watch(settingsNotifierProvider);
    final isWinner = gameState.score >= GameConfig.passingScore;

    return SingleChildScrollView(
      // padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildResultMessage(isWinner),
          AppSpacing.verticalSpaceLarge,
          _buildResultVisualization(gameState, theme, isWinner),
          AppSpacing.verticalSpaceLarge,
          _buildScoreDisplay(context, gameState, theme),
          AppSpacing.verticalSpaceLarge,
          _buildActionButtons(ref, settingsState, isWinner),
        ],
      ),
    );
  }

  /// Builds the result visualization with a circular progress indicator
  Widget _buildResultVisualization(
      GameScreenState gameState, ThemeData theme, bool isWinner) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary.withAlpha(25),
            theme.colorScheme.primary.withAlpha(13),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(
              minWidth: 200,
              minHeight: 200,
              maxWidth: 400,
              maxHeight: 400,
            ),
            child: CustomPaint(
              painter: _ResultProgressPainter(
                progress: gameState.score / GameConfig.maxScore,
                color: theme.colorScheme.primary,
              ),
            ),
          ),
          OverlappedGameIcons(
            items: gameState.matchedItems.take(5).toList(),
          ),
        ],
      ),
    );
  }

  /// Builds the score display with an animated scale effect
  /// and a fade-in effect for the text
  Widget _buildScoreDisplay(
      BuildContext context, GameScreenState gameState, ThemeData theme) {
    return AnimatedBuilder(
      animation: _controller, // Listen to animation updates
      builder: (context, child) {
        return Transform.scale(
          scale: _scoreScale.value, // Apply current scale value
          child: Opacity(
            opacity: _controller.value, // Gradually increase opacity
            child: Column(
              children: [
                Icon(getGameIcon(),
                    size: 32, color: Theme.of(context).colorScheme.primary),
                Text(
                  'score'.tr(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withAlpha(204),
                  ),
                ),
                AppSpacing.verticalSpaceSmall,
                Text(
                  "${gameState.score}/${GameConfig.maxScore}",
                  style: theme.textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: theme.colorScheme.primary,
                    shadows: [
                      Shadow(
                        color: theme.colorScheme.primary.withAlpha(51),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the result message (win/game over) with an icon and text
  /// The message slides in from the bottom and fades in
  Widget _buildResultMessage(bool isWinner) {
    return SlideTransition(
      position: _messageOffset, // Apply slide animation
      child: FadeTransition(
        opacity: _buttonOpacity, // Apply fade animation
        child: Column(
          children: [
            Icon(
              isWinner ? Icons.celebration : Icons.sentiment_very_dissatisfied,
              size: 60,
              color: isWinner ? Colors.green : Colors.amber,
            ),
            AppSpacing.verticalSpaceSmall,
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 900),
              // Smooth transition for text style changes
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.w700,
                color: isWinner ? Colors.green : Colors.red,
                shadows: [
                  Shadow(
                    color: Colors.black.withAlpha(25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Text(
                isWinner ? 'you_win'.tr() : 'game_over'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the action buttons (try again and next level)
  /// The buttons slide in from the bottom and fade in
  Widget _buildActionButtons(
      WidgetRef ref, SettingsState settingsState, bool isWinner) {
    return FadeTransition(
      opacity: _buttonOpacity, // Shared fade animation
      child: SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: _controller,
          curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
        )),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: Text('try_again'.tr()),
              style: AppTheme.elevatedButtonStyle().copyWith(
                padding: const WidgetStatePropertyAll(
                  EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                ),
              ),
              onPressed: () => _restartGame(ref, settingsState),
            ),
            if (isWinner &&
                settingsState.selectedLevel.number < GameConfig.maxLevel)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: ElevatedButton.icon(
                  iconAlignment: IconAlignment.end,
                  icon: const Icon(Icons.arrow_forward),
                  label: Text('next_game'.tr()),
                  style: AppTheme.elevatedButtonStyle().copyWith(
                    padding: const WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                    ),
                  ),
                  onPressed: () => _nextLevel(ref, settingsState),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // Function to restart the game
  void _restartGame(WidgetRef ref, SettingsState settingsState) async {
    await ref.read(gameScreenNotifierProvider.notifier).initGame(
          gameType: widget.gameType,
          currentLevel: settingsState.selectedLevel.number,
        );
  }

  // Function to go to the next level
  void _nextLevel(WidgetRef ref, SettingsState settingsState) async {
    final nextLevel =
        ref.read(settingsNotifierProvider.notifier).getNextGameLevel();
    await ref.read(gameScreenNotifierProvider.notifier).initGame(
          gameType: widget.gameType,
          currentLevel: nextLevel,
        );
  }

  // Function to get the icon based on the current game type
  IconData getGameIcon() {
    switch (widget.gameType) {
      case GameType.animal:
        return Icons.pets;
      case GameType.fruit:
        return Icons.apple;
      case GameType.color:
        return Icons.color_lens;
      case GameType.shape:
        return Icons.square_foot;
    }
  }
}

/// Custom painter to draw the result circular progress indicator circle
class _ResultProgressPainter extends CustomPainter {
  final double progress;
  final Color color;

  const _ResultProgressPainter({required this.progress, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withAlpha(25) // 10% opacity
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke; // Draw outline only

    final rect = Rect.fromCircle(
      center: size.center(Offset.zero),
      radius: size.width / 2,
    );

    // Draw the circular arc based on the progress starting from top (-π/2)
    canvas.drawArc(
      rect,
      -pi / 2, // Start angle (12 o'clock position)
      2 * pi * progress, // Sweep angle based on progress
      false, // Don't draw center to arc
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
