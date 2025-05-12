import 'package:flutter/material.dart';

/// This class contains the spacing constants used throughout the app.
/// It provides a consistent way to manage spacing in the UI.
class AppSizes {
  static double getDraggableHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.1;
  static double getDraggableWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.4;
  static double getDraggableFontSize(BuildContext context) =>
      MediaQuery.of(context).size.width / 12;

  static double getDragTargetHeight(BuildContext context) =>
      MediaQuery.of(context).size.height * 0.1;
  static double getDragTargetWidth(BuildContext context) =>
      MediaQuery.of(context).size.width * 0.35;
  static EdgeInsets defaultPadding(BuildContext context) =>
      EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.02,
      );
  static EdgeInsets gameScreenMainPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    // Mobile (Android/iOS)
    if (width < 450) {
      return EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      );
    }

    // Web or Desktop
    return EdgeInsets.symmetric(
      horizontal: width * 0.05,
      vertical: height * 0.03,
    );
  }

  static double get appBarTitleSize => 30;
  static double get choiceTextSize => 25;
  static double get feedbackIconSize => 60;
  static double get feedbackTextSize => 30;
}
