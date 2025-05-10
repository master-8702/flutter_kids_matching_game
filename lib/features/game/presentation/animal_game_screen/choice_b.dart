import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/core/utilities/app_sizes.dart';
import 'package:flutter_kids_matching_game/core/services/audio_service.dart';
import 'package:flutter_kids_matching_game/features/game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/features/game/presentation/notifiers/animal_game_screen_notifier.dart';

/// This widget is used to show the right side choices in the animal game
/// screen. It shows the images of the animals that are not draggable
/// (they are drag targets).
class ChoiceB extends ConsumerWidget {
  const ChoiceB({
    super.key,
    required AudioPlayer audioController,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalGameController = ref.watch(animalGameScreenNotifierProvider);
    final audioService = ref.read(audioServiceProvider);

    return Column(
      children: animalGameController.choiceB.map((choice) {
        final controller = ref.read(animalGameScreenNotifierProvider.notifier);
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
              await audioService.playError();
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
            return Container(
              color: Colors.white,
              height: AppSizes.getDragTargetHeight(context),
              width: AppSizes.getDragTargetWidth(context),
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              child: Image.asset(choice.image),
            );
          },
        );
      }).toList(),
    );
  }
}
