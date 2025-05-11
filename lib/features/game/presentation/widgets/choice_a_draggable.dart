import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/utilities/app_sizes.dart';
import 'package:flutter_kids_matching_game/features/game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/game_screen_notifier.dart';

/// This widget is used to show the left side choices in the game
/// screens. It shows the names of the animals/fruits/colors that are draggable.
/// The user can drag and drop these names to the right side choices
class ChoiceA extends ConsumerWidget {
  const ChoiceA({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameScreenNotifier = ref.watch(gameScreenNotifierProvider);

    return Column(
      children: gameScreenNotifier.choiceA.map((gameItem) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Draggable<GameItem>(
            maxSimultaneousDrags: 1,
            // data is the data that will be dropped by this draggable
            data: gameItem,
            // feedbacks are the widgets that we display while we are dragging
            // or the drag is under way
            // all the names here are translation aware
            feedback: Text(
              gameItem.name.tr(),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            // childWhenDragging are a widget to display instead of [child]
            // when one or more drags are under way.
            childWhenDragging: Container(
              padding: const EdgeInsets.all(12),
              height: AppSizes.getDraggableHeight(context),
              width: AppSizes.getDraggableWidth(context),
              child: Text(
                gameItem.name.tr(),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            // here the child widget(s) are the text names on the left side choices
            // that we can see them without touching the screen.
            child: FittedBox(
              child: Container(
                padding: const EdgeInsets.all(12),
                height: AppSizes.getDraggableHeight(context),
                width: AppSizes.getDraggableWidth(context),
                child: Text(
                  gameItem.name.tr(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
