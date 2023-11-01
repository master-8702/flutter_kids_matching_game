class GameItem {
  String image;
  String name;
  String value;
  bool accepting;
  String level;

  GameItem(
      {required this.image,
      required this.name,
      required this.value,
      this.accepting = false,
      required this.level});
}
