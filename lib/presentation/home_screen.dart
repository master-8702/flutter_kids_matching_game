import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/theme/app_theme.dart';

/// this class is our home screen where we will display a list of games
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      // screen name and settings icon
      appBar: AppBar(
        title: const Text('master_games').tr(),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, size: 36),
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, AppTheme.primaryColor],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'letsPlay'.tr(),
                  style: Theme.of(context).textTheme.displayMedium,
                  textAlign: TextAlign.center,
                ),
                // Cute Mascot Image
                const Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                  color: Colors.transparent, // Important for shadow to show
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/kid_mascot2.png'),
                      radius: 100,
                    ),
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                // Game Buttons
                GameButton(
                  label: 'colorGame'.tr(),
                  color: Colors.orange,
                  icon: Icons.color_lens,
                  onTap: () {
                    Navigator.pushNamed(context, '/colorGame');
                  },
                ),

                const SizedBox(height: 25),

                GameButton(
                  label: 'animalGame'.tr(),
                  color: Colors.green,
                  icon: Icons.pets,
                  onTap: () {
                    Navigator.pushNamed(context, '/animalGame');
                  },
                ),

                const SizedBox(height: 25),

                GameButton(
                  label: 'fruitGame'.tr(),
                  color: Colors.red,
                  icon: Icons.local_dining,
                  onTap: () {
                    Navigator.pushNamed(context, '/fruitGame');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// custom reusable Game Button Widget
class GameButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const GameButton({
    Key? key,
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: AppTheme.elevatedButtonStyle(),
      onPressed: onTap,
      icon: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          size: 36,
        ),
      ),
      label: Text(label),
    );
  }
}
