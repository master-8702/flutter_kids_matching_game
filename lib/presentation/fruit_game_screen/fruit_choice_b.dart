import 'package:flutter/material.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/domain/game_item.dart';
import 'package:flutter_kids_matching_game/presentation/fruit_game_screen/fruit_game_screen_controller.dart';

// a right side choices with the image of objects like colors, fruits ...
class FruitChoiceB extends ConsumerWidget {
  const FruitChoiceB({
    super.key,
    required AudioPlayer audioController,
  }) : _audioController = audioController;

  final AudioPlayer _audioController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fruitGameController = ref.watch(fruitGameScreenControllerProvider);

    return Column(
      children: fruitGameController.choiceB.map((choice) {
        final controller = ref.read(fruitGameScreenControllerProvider.notifier);
        return DragTarget<GameItem>(
          // here [onAccept] is Called when an acceptable piece of data was
          //dropped over this drag target.
          onAccept: (receivedItem) async {
            if (receivedItem.value == choice.value) {
              await _audioController
                  .play(AssetSource('sounds/success_bell2.mp3'));
              controller.removeAnsweredChoices(receivedItem);
              controller.scoreIncrement();

              choice.accepting = false;
            } else {
              choice.accepting = false;
              controller.scoreDecrement();
            }

            // if (!mounted) return;
          },
          onLeave: (receivedItem) {
            choice.accepting = false;
          },
          onWillAccept: (receivedItem) {
            // when the dragged items it about to be dropped on any target
            choice.accepting = true;
            return true;
          },
          builder: (context, acceptedItem, rejectedItem) {
            return Container(
              color:
                  // choice.accepting
                  // ? provider.themeColor
                  // :
                  Colors.white,
              height: 80,
              width: 105,
              alignment: Alignment.center,
              margin: const EdgeInsets.all(8),
              child: Image.asset(
                choice.image,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
