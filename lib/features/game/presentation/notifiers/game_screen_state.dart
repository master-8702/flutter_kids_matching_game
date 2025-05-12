import 'package:flutter/foundation.dart';

import 'package:flutter_kids_matching_game/features/game/domain/game_item.dart';

/// This class is our state class for the game screen
class GameScreenState {
  const GameScreenState({
    required this.score,
    required this.isGameOver,
    required this.choiceA,
    required this.choiceB,
    required this.matchedItems,
  });

  final int score;
  final bool isGameOver;
  final List<GameItem> choiceA;
  final List<GameItem> choiceB;
  final List<GameItem> matchedItems;

  GameScreenState copyWith({
    int? score,
    bool? isGameOver,
    List<GameItem>? choiceA,
    List<GameItem>? choiceB,
    List<GameItem>? matchedItems,
  }) {
    return GameScreenState(
        score: score ?? this.score,
        isGameOver: isGameOver ?? this.isGameOver,
        choiceA: choiceA ?? this.choiceA,
        choiceB: choiceB ?? this.choiceB,
        matchedItems: matchedItems ?? this.matchedItems);
  }

  @override
  bool operator ==(covariant GameScreenState other) {
    if (identical(this, other)) return true;

    return other.score == score &&
        other.isGameOver == isGameOver &&
        listEquals(other.choiceA, choiceA) &&
        listEquals(other.choiceB, choiceB) &&
        listEquals(other.matchedItems, matchedItems);
  }

  @override
  int get hashCode {
    return score.hashCode ^
        isGameOver.hashCode ^
        choiceA.hashCode ^
        choiceB.hashCode ^
        matchedItems.hashCode;
  }
}
