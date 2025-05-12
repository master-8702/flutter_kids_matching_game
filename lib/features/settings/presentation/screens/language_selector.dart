import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/constants/setting_choices.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/screens/build_dropdown.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/notifiers/settings_notifier.dart';

/// A widget that allows the user to select a language for the app.
class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsNotifierProvider);

    return buildDropdown<AppLanguage>(
      context: context,
      label: 'lesson_language'.tr(),
      value: settings.selectedLanguage,
      items: AppLanguage.values.map((lang) {
        return DropdownMenuItem<AppLanguage>(
          value: lang,
          child: Text(
            lang.translatedName,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        );
      }).toList(),
      onChanged: (appLanguage) {
        if (appLanguage != null) {
          // updating the new selected language on the UI
          context.setLocale(appLanguage.locale);
          // updating the state and local storage with the new selected language
          ref.read(settingsNotifierProvider.notifier).setLanguage(appLanguage);
        }
      },
    );
  }
}
