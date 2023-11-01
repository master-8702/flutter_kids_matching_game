import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter_kids_matching_game/provider/settings_controller.dart';
import 'package:flutter_kids_matching_game/presentation/settings_page/level_selector.dart';
import 'package:flutter_kids_matching_game/presentation/settings_page/language_selector.dart';
import 'package:flutter_kids_matching_game/presentation/settings_page/theme_color_selector.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsControllerProvider = ref.watch(settingsNotifierProvider);

    List<String> gameLevels = [
      AppLocalizations.of(context)!.level1,
      AppLocalizations.of(context)!.level2,
      AppLocalizations.of(context)!.level3,
      AppLocalizations.of(context)!.level4,
      AppLocalizations.of(context)!.level5,
    ];

    List<String> themeColors = [
      AppLocalizations.of(context)!.pink,
      AppLocalizations.of(context)!.purple,
      AppLocalizations.of(context)!.orange
    ];

    String tempLanguage = settingsControllerProvider.selectedLanguage;
    String tempLevel = settingsControllerProvider.level;
    int tempThemeCode = settingsControllerProvider.themeColorCode;

    var selectedLanguage = settingsControllerProvider.selectedLanguage == "አማርኛ"
        ? AppLocalizations.of(context)!.amharic
        : tempLanguage == "English"
            ? AppLocalizations.of(context)!.english
            : AppLocalizations.of(context)!.arabic;
    var selectedLevel = tempLevel.contains('1') == true
        ? AppLocalizations.of(context)!.level1
        : tempLevel.contains('2') == true
            ? AppLocalizations.of(context)!.level2
            : tempLevel.contains('3') == true
                ? AppLocalizations.of(context)!.level3
                : tempLevel.contains('4') == true
                    ? AppLocalizations.of(context)!.level4
                    : AppLocalizations.of(context)!.level5;

    var selectedThemeColorName = tempThemeCode == 0
        ? AppLocalizations.of(context)!.pink
        : tempThemeCode == 1
            ? AppLocalizations.of(context)!.purple
            : AppLocalizations.of(context)!.orange;

    var selectedThemeColor = settingsControllerProvider.themeColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.setting,
          style: const TextStyle(fontSize: 28),
        ),
      ),
      body: Material(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              LanguageSelector(
                  selectedLanguage: selectedLanguage,
                  settingsControllerProvider: settingsControllerProvider),
              LevelSelector(
                  selectedLevel: selectedLevel,
                  settingsControllerProvider: settingsControllerProvider,
                  selectedThemeColor: selectedThemeColor,
                  gameLevels: gameLevels),
              ThemeColorSelector(
                  selectedThemeColorName: selectedThemeColorName,
                  settingsControllerProvider: settingsControllerProvider,
                  themeColors: themeColors)
            ],
          ),
        ),
      ),
    );
  }
}
