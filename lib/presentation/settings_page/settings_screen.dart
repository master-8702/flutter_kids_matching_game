import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/l10n/l10n.dart';
import 'package:flutter_kids_matching_game/provider/settings_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Row(
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
                    style:
                        TextStyle(color: settingsControllerProvider.themeColor),
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
                    items:
                        L10n.all.map<DropdownMenuItem<String>>((Locale value) {
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
              ),
              Row(
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
                    style:
                        TextStyle(color: settingsControllerProvider.themeColor),
                    underline: Container(height: 2, color: selectedThemeColor),
                    onChanged: (String? newValue) {
                      if (newValue != null && newValue.isNotEmpty) {
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .setSelectedLevel(newValue);
                      }
                    },
                    items: gameLevels
                        .map<DropdownMenuItem<String>>((String value) {
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
              ),
              Row(
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
                    style:
                        TextStyle(color: settingsControllerProvider.themeColor),
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
                    items: themeColors
                        .map<DropdownMenuItem<String>>((String value) {
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
