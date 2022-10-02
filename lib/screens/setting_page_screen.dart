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
  late LocalProvider provider;
  final box = GetStorage();

  @override
  void initState() {
    // for later to save app state
    box.writeIfNull('selectedLanguage', 'English');
    box.writeIfNull('selectedLevel', 'Level 1');
    box.writeIfNull('selectedThemeColor', 'Pink');

//without saving state | state will reset everytime app restarts
//     box.writeIfNull('selectedLanguage', 'English');
//     box.write('selectedLevel', 'Level 1');
//     box.write('selectedThemeColor', 'Pink');

    selectedLanguage = box.read('selectedLanguage');
    selectedLevel = box.read('selectedLevel');
    selectedThemeColor = box.read('selectedThemeColor');

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
                          // selectedLevel = AppLocalizations.of(context)!.level1;
                          box.write('selectedLevel', 'ደረጃ 1');
                          box.write('selectedThemeColor', 'ሮዝ');
                        } else if (selectedLanguage == 'English') {
                          provider.setLocale(const Locale('en'));
                          box.write('selectedLevel', 'Level 1');
                          box.write('selectedThemeColor', 'Pink');
                        } else {
                          provider.setLocale(const Locale('ar'));
                          box.write('selectedLevel', 'المستوى 1');
                          box.write('selectedThemeColor', 'زهري');
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
                        selectedThemeColor = box.read('selectedThemeColor');
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
