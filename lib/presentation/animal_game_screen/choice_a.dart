import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_kids_matching_game/models/gameItems.dart';
import 'package:flutter_kids_matching_game/presentation/animal_game_screen/animal_game_screen_controller.dart';

// a left side choices with the name of objects like animals, colors ...
class ChoiceA extends ConsumerWidget {
  const ChoiceA({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final animalGameController = ref.watch(animalGameScreenControllerProvider);
    return Column(
      children: animalGameController.choiceA.map((choice) {
        return Container(
          margin: const EdgeInsets.all(8),
          child: Draggable<GameItem>(
            maxSimultaneousDrags: 1,
            // data is the data that will be dropped by this draggable
            data: choice,
            // feedbacks are the widgets that we display while we are dragging
            // or the drag is under way
            feedback: Text(
              choice.name,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            // childWhenDragging are a widget to display instead of [child]
            //when one or more drags are under way.
            childWhenDragging: Container(
              padding: const EdgeInsets.all(12),
              height: 80,
              width: 150,
              child: Text(
                choice.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
              ),
            ),
            // here the child widget(s) are the text names on the left side choices
            //that we can see them without touching the screen.
            child: Container(
              padding: const EdgeInsets.all(12),
              height: 80,
              width: 150,
              child: Text(
                choice.name,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
