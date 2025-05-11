import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/core/services/audio_service.dart';
import 'package:flutter_kids_matching_game/features/game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/widgets/game_drag_target_card.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/game_screen_notifier.dart';

/// This widget is used to show the right side choices in the game
/// screens. It shows the images of the animals/fruits/colors that are not
/// draggable (they are drag targets).
class ChoiceB extends ConsumerWidget {
  const ChoiceB({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameScreenNotifier = ref.watch(gameScreenNotifierProvider);
    final audioService = ref.read(audioServiceProvider);

    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: 12,
      children: gameScreenNotifier.choiceB.map((choice) {
        final controller = ref.read(gameScreenNotifierProvider.notifier);

        return DragTarget<GameItem>(
          // here [onAccept] is Called when an acceptable piece of data was
          // dropped over this drag target.
          onAcceptWithDetails: (receivedItem) async {
            if (receivedItem.data.value == choice.value) {
              await audioService.playSuccess();
              controller.removeAnsweredChoices(receivedItem.data);
              controller.scoreIncrement();

              choice.accepting = false;
            } else {
              // await audioService.playError();
              choice.accepting = false;
              controller.scoreDecrement();
            }

            // if (!mounted) return;
          },
          // Called when a given piece of data being dragged over this target
          // leaves the target.
          onLeave: (receivedItem) {
            choice.accepting = false;
          },
          // when the dragged items it about to be dropped on this target
          onWillAcceptWithDetails: (receivedItem) {
            choice.accepting = true;
            return true;
          },
          builder: (context, acceptedItem, rejectedItem) {
            // here we are using the GameDragTargetCard widget to show the
            // images of the animals/fruits/colors that are drag targets
            return GameDragTargetCard(
              imagePath: choice.image,
            );
          },
        );
      }).toList(),
    );
  }
}
