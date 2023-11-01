import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_kids_matching_game/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_kids_matching_game/data/settings_state.dart';
import 'package:flutter_kids_matching_game/provider/settings_controller.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({
    super.key,
    required this.selectedLanguage,
    required this.settingsControllerProvider,
  });

  final String selectedLanguage;
  final SettingState settingsControllerProvider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.lessonLanguage,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(
          width: 30,
        ),
        DropdownButton<String>(
          value: selectedLanguage,
          icon: const Icon(Icons.translate),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: settingsControllerProvider.themeColor),
          underline: Container(
            height: 2,
            color: settingsControllerProvider.themeColor,
          ),
          onChanged: (String? newValue) {
            print(newValue);
            if (newValue != null && newValue.isNotEmpty) {
              ref
                  .read(settingsNotifierProvider.notifier)
                  .setSelectedLanguage(newValue);
            }
          },
          items: L10n.all.map<DropdownMenuItem<String>>((Locale value) {
            return DropdownMenuItem<String>(
              value: L10n.getLanguages(value.toString()),
              child: Text(
                L10n.getLanguages(value.toString()),
                style: const TextStyle(fontSize: 18),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
