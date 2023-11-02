import 'package:flutter/foundation.dart';

import 'package:flutter_kids_matching_game/domain/game_item.dart';

class GameScreenState {
  const GameScreenState({
    required this.score,
    required this.isGameOver,
    required this.choiceA,
    required this.choiceB,
  });

  final int score;
  final bool isGameOver;
  // Utilities utilities = Utilities();

  final List<GameItem> choiceA;
  final List<GameItem> choiceB;

  GameScreenState copyWith({
    int? score,
    bool? isGameOver,
    List<GameItem>? choiceA,
    List<GameItem>? choiceB,
  }) {
    return GameScreenState(
        score: score ?? this.score,
        isGameOver: isGameOver ?? this.isGameOver,
        choiceA: choiceA ?? this.choiceA,
        choiceB: choiceB ?? this.choiceB);
  }

  @override
  bool operator ==(covariant GameScreenState other) {
    if (identical(this, other)) return true;

    return other.score == score &&
        other.isGameOver == isGameOver &&
        listEquals(other.choiceA, choiceA) &&
        listEquals(other.choiceB, choiceB);
  }

  @override
  int get hashCode {
    return score.hashCode ^
        isGameOver.hashCode ^
        choiceA.hashCode ^
        choiceB.hashCode;
  }
}
