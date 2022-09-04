import 'package:flutter/material.dart';
import 'package:flutter_kids_matching_game/l10n/l10n.dart';
import 'package:flutter_kids_matching_game/provider/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingPageScreen extends StatefulWidget {
  const SettingPageScreen({Key? key}) : super(key: key);

  @override
  State<SettingPageScreen> createState() => _SettingPageScreenState();
}

class _SettingPageScreenState extends State<SettingPageScreen> {
  String selectedLanguage = "አማርኛ";
  String selectedLevel = "ደረጃ 1";
  String selectedThemeColor = "ሮዝ";

  late LocalProvider provider;

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
                        // Navigator.popAndPushNamed(context, '/setting');
                        provider =
                            Provider.of<LocalProvider>(context, listen: false);
                        selectedLanguage = newValue!;
                        // selectedLevel = provider.;
                        // selectedThemeColor = "";

                        if (selectedLanguage == 'አማርኛ') {
                          provider.setLocale(const Locale('am'));
                          selectedLevel = "ደረጃ 1";
                          selectedThemeColor = "ሮዝ";
                        } else if (selectedLanguage == 'English') {
                          provider.setLocale(const Locale('en'));
                          selectedLevel = "Level 1";
                          selectedThemeColor = "Pink";
                        } else {
                          provider.setLocale(const Locale('ar'));
                          selectedLevel = "المستوى 1";
                          selectedThemeColor = "زهري";
                        }
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
                        selectedLevel = newValue!;
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
                        selectedThemeColor = newValue!;
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
