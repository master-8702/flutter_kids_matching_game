import 'package:get_storage/get_storage.dart';

class Utilities {
  late int selectedGameLevel;
  late String temp;

  int getGameLevel() {
    temp = GetStorage().read('selectedLevel');
    if (temp.contains('1')) {
      selectedGameLevel = 1;
    } else if (temp.contains('2')) {
      selectedGameLevel = 2;
    } else if (temp.contains('3')) {
      selectedGameLevel = 3;
    } else if (temp.contains('4')) {
      selectedGameLevel = 4;
    } else {
      selectedGameLevel = 5;
    }

    return selectedGameLevel;
  }

  void nextGameLevel() {
    temp = GetStorage().read('selectedLevel');
    if (temp.contains('1')) {
      GetStorage().write('selectedLevel', "Level 2");
    } else if (temp.contains('2')) {
      GetStorage().write('selectedLevel', "Level 3");
    } else if (temp.contains('3')) {
      GetStorage().write('selectedLevel', "Level 4");
    } else {
      GetStorage().write('selectedLevel', "Level 5");
    }
  }
}
