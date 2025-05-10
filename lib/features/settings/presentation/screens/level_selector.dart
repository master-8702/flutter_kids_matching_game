import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/constants/setting_choices.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/screens/build_dropdown.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_notifier.dart';

/// A widget that allows the user to select a game level for the app.
class LevelSelector extends ConsumerWidget {
  const LevelSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);

    return buildDropdown<GameLevel>(
      context: context,
      label: 'gameLevel'.tr(),
      value: settings.selectedLevel,
      items: GameLevel.values.map((level) {
        return DropdownMenuItem<GameLevel>(
          value: level,
          child: Text(
            level.translatedName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        );
      }).toList(),
      onChanged: (gameLevel) {
        if (gameLevel != null) {
          // updating the state and local storage with the new selected level
          ref.read(settingsNotifierProvider.notifier).setLevel(gameLevel);
        }
      },
    );
  }
}
