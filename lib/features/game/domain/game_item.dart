/// This class represents a game item with its properties.
class GameItem {
  String image;
  String name;
  String value;
  bool accepting;
  int level;

  GameItem(
      {required this.image,
      required this.name,
      required this.value,
      this.accepting = false,
      required this.level});
}
