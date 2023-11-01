import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_kids_matching_game/data/settings_state.dart';
import 'package:flutter_kids_matching_game/provider/settings_controller.dart';

class ThemeColorSelector extends ConsumerWidget {
  const ThemeColorSelector({
    super.key,
    required this.selectedThemeColorName,
    required this.settingsControllerProvider,
    required this.themeColors,
  });

  final String selectedThemeColorName;
  final SettingState settingsControllerProvider;
  final List<String> themeColors;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.themeColor,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 30,
        ),
        DropdownButton<String>(
          value: selectedThemeColorName,
          icon: const Icon(Icons.color_lens),
          iconSize: 24,
          elevation: 6,
          style: TextStyle(color: settingsControllerProvider.themeColor),
          underline: Container(
            height: 2,
            color: settingsControllerProvider.themeColor,
          ),
          onChanged: (String? newValue) async {
            if (newValue != null && newValue.isNotEmpty) {
              var temp = themeColors.indexOf(newValue);
              await ref
                  .read(settingsNotifierProvider.notifier)
                  .setSelectedThemeCode(temp);
            }
          },
          items: themeColors.map<DropdownMenuItem<String>>((String value) {
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
