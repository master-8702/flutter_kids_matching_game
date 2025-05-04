import 'package:flutter/material.dart';

import 'package:flutter_kids_matching_game/constants/setting_choices.dart';

/// This class will be used for defining the overall look and feel of the app
class AppTheme {
  // Base Colors (will be overridden dynamically)
  static Color primaryColor = Colors.deepPurple;
  static Color secondaryColor = Colors.deepPurpleAccent;
  // soft pink background
  static const Color backgroundColor = Color(0xFFFDECEF);
  // white with 95% opacity
  static const Color cardColor = Color(0xF2FFFFFF);
  // default font
  static const String fontFamily = AppFonts.nunito;

  // Gradient for Backgrounds
  static LinearGradient backgroundGradient({Color? primary, Color? secondary}) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [primary ?? Colors.white, secondary ?? primaryColor],
    );
  }

  // text theme (text styles) for different text types in our app
  static TextTheme get textTheme => const TextTheme(
        // Big titles like "Master Games", "Settings"
        displayLarge: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.2,
          fontFamily: AppFonts.sunnyspells,
        ),

        // Section headers like "Select Language"
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          height: 1.3,
          fontFamily: AppFonts.fredoka,
        ),

        // Game level names, buttons
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: AppFonts.fredoka,
        ),

        // Main body text, instructions
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
          height: 1.5,
          fontFamily: AppFonts.nunito,
        ),

        // Subtitle or secondary labels
        bodyMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          color: Colors.black54,
          height: 1.4,
          fontFamily: AppFonts.nunito,
        ),

        // Small hints or UI texts
        bodySmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          color: Colors.black45,
          fontFamily: AppFonts.nunito,
        ),

        // For buttons, menu items
        labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontFamily: AppFonts.fredoka,
        ),

        // For sub-labels in settings
        labelMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
          fontFamily: AppFonts.fredoka,
        ),
      );

  // Button Styles
  static ButtonStyle elevatedButtonStyle({Color? primary}) {
    return ElevatedButton.styleFrom(
      backgroundColor: primary ?? primaryColor,
      // backgroundColor: Colors.transparent,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))),
      // textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: fontFamily),
      textStyle: textTheme.labelLarge,
      iconColor: Colors.black,
      elevation: 8,
      iconSize: 32,
    );
  }

  // outline button theme
  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor,
    side: BorderSide(color: primaryColor),
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16))),
    textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  );

  // icon theme
  static const IconThemeData iconTheme = IconThemeData(
    color: Colors.black,
    size: 32,
  );

  // Input Decoration Theme
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    labelStyle: const TextStyle(color: Colors.black54),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  // Card Theme
  static final CardTheme cardTheme = CardTheme(
    color: cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    elevation: 2,
    margin: const EdgeInsets.all(8),
  );

  // AppBar Theme
  static AppBarTheme appBarTheme({Color? primary}) {
    return AppBarTheme(
      backgroundColor: primary ?? primaryColor,
      foregroundColor: Colors.white,
      titleTextStyle: textTheme.displayLarge,
      centerTitle: true,
      elevation: 4,
    );
  }

  // Dialog Theme
  static final DialogTheme dialogTheme = DialogTheme(
    backgroundColor: cardColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );

  // 🎨 This is the key part: generate theme based on selected color
  static ThemeData getThemeFor(ThemeColor themeColor) {
    late final Color primary;
    // late final Color secondary;

    switch (themeColor) {
      case ThemeColor.pink:
        // these two are if we pass color in development for the reusable styles
        // that we defined above like [appBarTheme]
        primary = Colors.pink;
        // secondary = Colors.pinkAccent;

        // and these two are for general theme color that we pass from the
        // settings screen using the custom AppColor class
        primaryColor = Colors.pink;
        secondaryColor = Colors.pinkAccent;
        break;
      case ThemeColor.purple:
        primary = Colors.deepPurple;
        // secondary = Colors.purpleAccent;

        primaryColor = Colors.deepPurple;
        secondaryColor = Colors.purpleAccent;
        break;
      case ThemeColor.orange:
        primary = Colors.deepOrange;
        // secondary = Colors.yellowAccent;

        primaryColor = Colors.deepOrange;
        secondaryColor = Colors.yellowAccent;
        break;
    }

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      // setting global font family
      fontFamily: fontFamily,

      // 🌈 Update seed color + gradients
      colorScheme: ColorScheme.fromSeed(seedColor: primary),

      // 🖍️ Text & Icons
      textTheme: textTheme,
      iconTheme: iconTheme,

      // 🎯 Buttons
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: elevatedButtonStyle(primary: primary)),
      outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),

      // 📄 Inputs
      inputDecorationTheme: inputDecorationTheme,

      // 📦 Cards
      cardTheme: cardTheme,

      // 📱 AppBar
      appBarTheme: appBarTheme(primary: primary),

      // 💬 Dialogs
      dialogTheme: dialogTheme,

      // 🎨 Background
      scaffoldBackgroundColor: backgroundColor,
    );
  }
}

// app fonts class to use font name easily
class AppFonts {
  static const String fredoka = 'Fredoka';
  static const String nunito = 'Nunito';
  static const String princessSofia = 'PrincessSofia';
  static const String sunnyspells = 'Sunnyspells';
}
