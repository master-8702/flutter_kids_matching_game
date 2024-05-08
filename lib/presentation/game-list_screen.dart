import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            "Master Games",
            style: TextStyle(fontSize: 40),
          ),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: IconButton(
                icon: const Icon(
                  Icons.settings,
                  size: 50,
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/setting');
                },
              ),
            ),
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   elevation: 10,
                //   shape: BeveledRectangleBorder(
                //       borderRadius: BorderRadius.circular(120)),
                // ),
                onPressed: () {
                  Navigator.pushNamed(context, '/colorGame');
                },
                child: Text(
                  AppLocalizations.of(context)!.colorGame,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                // style: ElevatedButton.styleFrom(
                //   elevation: 10,
                //   shape: BeveledRectangleBorder(
                //       borderRadius: BorderRadius.circular(120)),
                // ),
                onPressed: () {
                  Navigator.pushNamed(context, '/animalGame');
                },
                child: Text(
                  AppLocalizations.of(context)!.animalGame,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/fruitGame');
                },
                child: Text(
                  AppLocalizations.of(context)!.fruitGame,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
