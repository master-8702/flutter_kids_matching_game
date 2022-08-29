import 'package:flutter/material.dart';

class GameListScreen extends StatefulWidget {
  const GameListScreen({Key? key}) : super(key: key);

  @override
  State<GameListScreen> createState() => _GameListScreenState();
}

class _GameListScreenState extends State<GameListScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 120,
            ),
            const ElevatedButton(
              onPressed: null,
              child: Text(
                "Master Games",
                style: TextStyle(
                  fontSize: 50,
                  color: Colors.pink,
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Expanded(
              flex: 3,
              child: Column(
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
                    child: const Text("Color Game"),
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
                    child: const Text("Animal Game"),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/fruitGame');
                    },
                    child: const Text("Fruit Game"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
