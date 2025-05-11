import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/features/game/domain/game_item.dart';

/// This widget is used to show the overlapped game icons. It takes a list of 
/// [GameItem] and displays them in a semi-circle layout open downward with 
/// overlapping icons.
class OverlappedGameIcons extends StatelessWidget {
  final List<GameItem> items;

  const OverlappedGameIcons({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Max number of icons to show
    final count = items.length;
    const radius = 60.0; // Size of the arc
    const centerOffset = 80.0; // Center point offset

    return SizedBox(
      width: 200,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          for (int i = 0; i < count; i++)
            _buildIcon(context, i, items[i], count, radius, centerOffset),
        ],
      ),
    );
  }

  Widget _buildIcon(BuildContext context, int index, GameItem item, int count,
      double radius, double centerOffset) {
    // Distribute icons across a semi-circle (from left to right)
    final angle = pi * (1 + index / (count - 1)); // Start from bottom center
    final x = radius * cos(angle);
    final y = radius * sin(angle);

    // Scale icons as they go outward
    final scale = 1.0 - (index.toDouble() / count) * 0.4;

    return Positioned(
      left: centerOffset + x - 10, // Centered adjustment
      top: centerOffset + y - 40,
      child: Transform.scale(
        scale: scale,
        // scale: 0.6,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            // color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            color: Theme.of(context).colorScheme.primary.withAlpha(50),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          child: Image.asset(
            item.image,
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
