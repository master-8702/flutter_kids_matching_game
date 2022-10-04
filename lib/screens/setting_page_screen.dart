import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/l10n/l10n.dart';
import 'package:flutter_kids_matching_game/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_storage/get_storage.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({Key? key}) : super(key: key);

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {
  late String selectedLanguage;
  late String selectedLevel;
  late String selectedThemeColor;
  late String selectedThemeCode;
  late LocalProvider provider;
  final box = GetStorage();

  @override
  void initState() {
    // The following variables will be used to save the  app state like selected language, theme color and game level
    // we will read them(the sates) from local storage if there is any but if the app runs for the first time (there are no any states)
    // we will assign initial values
    box.writeIfNull('selectedLanguage', 'English');
    box.writeIfNull('selectedLevel', 'Level 1');
    box.writeIfNull('selectedThemeColor', 'Pink');
    box.writeIfNull('selectedThemeCode', '0');

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> gameLevels = [
      AppLocalizations.of(context)!.level1,
      AppLocalizations.of(context)!.level2,
      AppLocalizations.of(context)!.level3
    ];

    List<String> themeColors = [
      AppLocalizations.of(context)!.pink,
      AppLocalizations.of(context)!.purple,
      AppLocalizations.of(context)!.orange
    ];

    String tempLanguage = box.read('selectedLanguage');
    String tempLevel = box.read('selectedLevel');
    int selectedThemeCode = box.read('selectedThemeCode');

    selectedLanguage = tempLanguage == "አማርኛ"
        ? AppLocalizations.of(context)!.amharic
        : tempLanguage == "English"
            ? AppLocalizations.of(context)!.english
            : AppLocalizations.of(context)!.arabic;
    selectedLevel = tempLevel.contains('1') == true
        ? AppLocalizations.of(context)!.level1
        : tempLevel.contains('2') == true
            ? AppLocalizations.of(context)!.level2
            : AppLocalizations.of(context)!.level3;
    selectedThemeColor = selectedThemeCode == 0
        ? AppLocalizations.of(context)!.pink
        : selectedThemeCode == 1
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
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        provider =
                            Provider.of<LocalProvider>(context, listen: false);
                        box.write('selectedLanguage', newValue);

                        selectedLanguage = box.read('selectedLanguage');

                        if (selectedLanguage == 'አማርኛ') {
                          provider.setLocale(const Locale('am'));
                          box.write('selectedLocale', 'am');
                        } else if (selectedLanguage == 'العربية') {
                          provider.setLocale(const Locale('ar'));
                          box.write('selectedLocale', 'ar');
                        } else {
                          provider.setLocale(const Locale('en'));
                          box.write('selectedLocale', 'en');
                        }
                        selectedLevel = box.read('selectedLevel');
                        selectedThemeColor = box.read('selectedThemeColor');
                      });
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
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        box.write('selectedLevel', newValue);
                        selectedLevel = box.read('selectedLevel');
                      });
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
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        box.write('selectedThemeColor', newValue);
                        box.write('selectedThemeCode',
                            themeColors.indexOf(newValue!));
                        selectedThemeColor = box.read('selectedThemeColor');
                        selectedThemeCode = box.read('selectedThemeCode');
                      });
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
