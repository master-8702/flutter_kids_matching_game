// import 'package:flutter/material.dart';
// import 'gameItems.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// class GameLists extends StatefulWidget {
//   const GameLists({Key? key}) : super(key: key);
//
//   @override
//   State<GameLists> createState() => _GameListsState();
//
//   List<GameItem> get getList {
//     _GameListsState gls = _GameListsState();
//     List<GameItem> choice_A;
//     choice_A = gls.choice_A;
//     print("here");
//     print(choice_A);
//     return choice_A;
//   }
// }
//
// class _GameListsState extends State<GameLists> {
//   late List<GameItem> choice_A;
//   late List<GameItem> choice_B;
//   @override
//   Widget build(BuildContext context) {
//     final localization = AppLocalizations.of(context);
//     choice_A = [
//       GameItem(
//           image: "assets/images/animals/Doe.png",
//           name: AppLocalizations.of(context)!.doe,
//           value: localization!.doe),
//       GameItem(
//           image: "assets/images/animals/Elephant.png",
//           name: localization!.elephant,
//           value: localization!.elephant),
//       GameItem(
//           image: "assets/images/animals/Ewe.png",
//           name: localization!.ewe,
//           value: localization!.ewe),
//       GameItem(
//           image: "assets/images/animals/Giraffe.png",
//           name: localization!.giraffe,
//           value: localization!.giraffe),
//       GameItem(
//           image: "assets/images/animals/Mule.png",
//           name: localization!.mule,
//           value: localization!.mule),
//       GameItem(
//           image: "assets/images/animals/Ostrich.png",
//           name: localization!.ostrich,
//           value: localization!.ostrich),
//     ];
//     choice_B = List<GameItem>.from(choice_A);
//
//     choice_A.shuffle();
//     choice_B.shuffle();
//     print(choice_A);
//     print(choice_B);
//     // return Text(data)
//   }
// }
