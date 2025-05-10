import 'package:flutter/material.dart';

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
        title: Text("Settings", style: AppTheme.textTheme.displayLarge),
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
              title: 'lessonLanguage'.tr(),
              child: const LanguageSelector(),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.school,
              title: 'gameLevel'.tr(),
              child: const LevelSelector(),
            ),
            const SizedBox(height: 20),
            _buildSection(
              context,
              icon: Icons.palette,
              title: 'themeColor'.tr(),
              child: const ThemeColorSelector(),
            ),
            const Spacer(),
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
}
