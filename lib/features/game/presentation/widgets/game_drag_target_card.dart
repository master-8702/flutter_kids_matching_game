import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_kids_matching_game/core/utilities/app_sizes.dart';

/// A widget that represents a draggable card in the game.
/// It displays an image and has a specific height and width.
class GameDragTargetCard extends StatelessWidget {
  final String imagePath;

  const GameDragTargetCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.getDraggableHeight(context),
      width: AppSizes.getDraggableWidth(context),
      alignment: Alignment.center,
      // The ClipRRect widget is used to create rounded corners for the card.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(50),
            border: Border.all(
              color: Colors.black.withAlpha(255),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withAlpha(100),
                blurRadius: 8,
                spreadRadius: 2,
              )
            ],
          ),
          // The BackdropFilter widget applies a blur effect to the background
          // of the container, creating a frosted glass effect.
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(25),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                height: 80,
                width: 100,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
