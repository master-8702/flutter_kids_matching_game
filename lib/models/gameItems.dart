import 'package:flutter/material.dart';

class GameItem {
  String image;
  String name;
  String value;
  bool accepting;

  GameItem(
      {required this.image,
      required this.name,
      required this.value,
      this.accepting = false});
}
