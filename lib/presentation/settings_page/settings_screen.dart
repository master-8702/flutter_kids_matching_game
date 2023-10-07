import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/data/local_settings_repository.dart';
import 'package:flutter_kids_matching_game/l10n/l10n.dart';
import 'package:flutter_kids_matching_game/provider/settings_controller.dart';
import 'package:flutter_kids_matching_game/provider/settings_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsController = ref.watch(settingsNotifierProvider);

    String selectedLanguage = settingsController.selectedLanguage;
    // String selectedLevel = settingsProvider.getSelectedLevel();

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

    String tempLanguage = settingsController.selectedLanguage;
    String tempLevel = settingsController.level;
    int tempThemeCode = settingsController.themeColorCode;

    selectedLanguage = settingsController.selectedLanguage == "አማርኛ"
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

    var selectedThemeColor = tempThemeCode == 0
        ? AppLocalizations.of(context)!.pink
        : tempThemeCode == 1
            ? AppLocalizations.of(context)!.purple
            : AppLocalizations.of(context)!.orange;

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
                    style: TextStyle(color: settingsController.themeColor),
                    underline: Container(
                      height: 2,
                      color: settingsController.themeColor,
                    ),
                    onChanged: (String? newValue) {
                      print(newValue);
                      if (newValue != null && newValue.isNotEmpty) {
                        // settingsProvider.setSelectedLanguage(newValue);
                        // selectedLanguage =
                        //     settingsProvider.getSelectedLanguage();
                        // ref.read(settingsNotifierProvider.notifier).setLocale(
                        //     settingsProvider.getSelectedLocal() as Locale);
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .setSelectedLanguage(newValue);
                      }

                      //   if (selectedLanguage == 'አማርኛ') {
                      //     provider.setLocale(const Locale('am'));
                      //     box.write('selectedLocale', 'am');
                      //   } else if (selectedLanguage == 'العربية') {
                      //     provider.setLocale(const Locale('ar'));
                      //     box.write('selectedLocale', 'ar');
                      //   } else {
                      //     provider.setLocale(const Locale('en'));
                      //     box.write('selectedLocale', 'en');
                      //   }
                      //   selectedLevel = box.read('selectedLevel');
                      //   selectedThemeColor = box.read('selectedThemeColor');
                      // });
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
                    style: TextStyle(color: settingsController.themeColor),
                    underline: Container(
                      height: 2,
                      color: settingsController.themeColor,
                    ),
                    onChanged: (String? newValue) {
                      // setState(() {
                      // box.write('selectedLevel', newValue);
                      if (newValue != null && newValue.isNotEmpty) {
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .setSelectedLevel(newValue);
                      }
                      // selectedLevel = box.read('selectedLevel');
                      // });
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
                    value: selectedThemeColor,
                    icon: const Icon(Icons.color_lens),
                    iconSize: 24,
                    elevation: 6,
                    style: TextStyle(color: settingsController.themeColor),
                    underline: Container(
                      height: 2,
                      color: settingsController.themeColor,
                    ),
                    onChanged: (String? newValue) async {
                      // setState(() {
                      if (newValue != null && newValue.isNotEmpty) {
                        // settingsProvider.setSelectedThemeColor(newValue);
                        // settingsProvider.setSelectedThemeCode(
                        //     themeColors.indexOf(newValue).toString());
                        var temp = themeColors.indexOf(newValue);
                        await ref
                            .read(settingsNotifierProvider.notifier)
                            .setSelectedThemeCode(Localizations.localeOf(context.) .of(context).apple. newValue.toLowerCase());

                        // ref
                        //     .read(settingsNotifierProvider.notifier).setSelectedThemeColor(newValue);
                        //     .setTheme(themeColors.indexOf(newValue));
                      }
                      //   box.write('selectedThemeColor', newValue);
                      //   box.write('selectedThemeCode',
                      //       themeColors.indexOf(newValue!));
                      //   selectedThemeColor = box.read('selectedThemeColor');
                      //   selectedThemeCode = box.read('selectedThemeCode');
                      //   provider = Provider.of<SettingsProvider>(context,
                      //       listen: false);
                      //   provider.setTheme(themeColors.indexOf(newValue));
                      // });
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
