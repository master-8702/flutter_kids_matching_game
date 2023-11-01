import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_kids_matching_game/data/settings_state.dart';
import 'package:flutter_kids_matching_game/provider/settings_controller.dart';

class LevelSelector extends ConsumerWidget {
  const LevelSelector({
    super.key,
    required this.selectedLevel,
    required this.settingsControllerProvider,
    required this.selectedThemeColor,
    required this.gameLevels,
  });

  final String selectedLevel;
  final SettingState settingsControllerProvider;
  final Color selectedThemeColor;
  final List<String> gameLevels;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.gameLevel,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 30,
        ),
        DropdownButton<String>(
          value: selectedLevel,
          icon: const Icon(Icons.arrow_upward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: settingsControllerProvider.themeColor),
          underline: Container(height: 2, color: selectedThemeColor),
          onChanged: (String? newValue) {
            if (newValue != null && newValue.isNotEmpty) {
              ref
                  .read(settingsNotifierProvider.notifier)
                  .setSelectedLevel(newValue);
            }
          },
          items: gameLevels.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
