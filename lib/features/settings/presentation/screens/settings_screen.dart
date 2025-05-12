import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_kids_matching_game/core/theme/app_theme.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/screens/level_selector.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/screens/language_selector.dart';
import 'package:flutter_kids_matching_game/features/settings/presentation/screens/theme_color_selector.dart';

/// this is the settings screen of the app
class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('settings', style: AppTheme.textTheme.displayLarge).tr(),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              AppTheme.primaryColor,
            ],
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              context,
              icon: Icons.language,
              title: 'lesson_language'.tr(),
              child: const LanguageSelector(),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.school,
              title: 'game_level'.tr(),
              child: const LevelSelector(),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.palette,
              title: 'theme_color'.tr(),
              child: const ThemeColorSelector(),
            ),
            const Spacer(),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  /// A utility function to build a section with an icon, title, and child widget.
  Widget _buildSection(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  // this method will build the footer of the settings page
  // it will contain the developer name and the version of the app
  Column _buildFooter(BuildContext context) {
    return Column(
      children: [
        const Divider(
          thickness: 5, // thickness of the line
          indent: 20, // empty space to the leading edge of divider.
          endIndent: 20, // empty space to the trailing edge of the divider.
          color: Colors.black, // The color to use when painting the line.
          height: 20, // The divider's height extent.
        ),
        InkWell(
            onTap: () => _copyEmailToClipboard(context),
            onLongPress: () => ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: const Text('developed_by_name').tr()),
                ),
            child: Text.rich(
              TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 18),
                children: [
                  TextSpan(
                      text: 'developed_by'.tr(),
                      style: const TextStyle(fontSize: 25)),
                  TextSpan(
                    text: 'ibs'.tr(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),           
            )),
        Text('${'version'.tr()} 1.5.0'),
        const Divider(
          // already const, no change needed
          thickness: 5,
          indent: 20, endIndent: 20,
          color: Colors.black,
          height: 20,
        ),
      ],
    );
  }

  // this method will copy the email to the clipboard
  void _copyEmailToClipboard(BuildContext context) {
    const email = 'contact@ibrahimselman.com';

    Clipboard.setData(const ClipboardData(text: email)).then((_) {
      // Show snackbar to  notify the user that the email is copied
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('email_copied'.tr())),
      );
    });
  }
}
