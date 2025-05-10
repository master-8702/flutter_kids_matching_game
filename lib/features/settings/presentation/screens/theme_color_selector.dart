import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/constants/setting_choices.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/screens/build_dropdown.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_notifier.dart';

/// A widget that allows the user to select a theme color for the app.
class ThemeColorSelector extends ConsumerWidget {
  const ThemeColorSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);

    return buildDropdown<ThemeColor>(
      context: context,
      label: 'themeColor'.tr(),
      value: settings.selectedThemeColor,
      items: ThemeColor.values.map((color) {
        return DropdownMenuItem<ThemeColor>(
          value: color,
          child: Text(
            color.translatedName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        );
      }).toList(),
      onChanged: (themeColor) {
        if (themeColor != null) {
          // updating the state and local storage with the new selected theme color
          ref.read(settingsNotifierProvider.notifier).setThemeColor(themeColor);
        }
      },
    );
  }
}
