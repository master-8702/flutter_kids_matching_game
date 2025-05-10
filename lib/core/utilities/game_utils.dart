import 'package:flutter_kids_matching_game/features/game/domain/game_item.dart';

/// This class contains utility methods for the game.
class GameUtils {
  /// This method is used to remove the matched item from the list of items.
  static List<GameItem> removeMatchedItemFromList(
      List<GameItem> list, GameItem item) {
    return list.where((i) => i != item).toList();
  }
}
