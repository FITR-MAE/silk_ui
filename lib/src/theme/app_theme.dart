import 'package:flutter/material.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: SilkColors.cherryBlossom,
        onPrimary: SilkColors.dark,
        secondary: SilkColors.powderPetal,
        onSecondary: SilkColors.dark,
        tertiary: SilkColors.dustyMauve,
        onTertiary: SilkColors.light,
        surface: SilkColors.light,
        onSurface: SilkColors.dark,
        outline: SilkColors.cherryBlossom,
        error: SilkColors.dustyMauve,
        onError: SilkColors.light,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: SilkColors.light,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: SilkColors.cherryBlossom,
        onPrimary: SilkColors.light,
        secondary: SilkColors.powderPetal,
        onSecondary: SilkColors.dark,
        tertiary: SilkColors.dustyMauve,
        onTertiary: SilkColors.light,
        surface: SilkColors.dark,
        onSurface: SilkColors.light,
        outline: SilkColors.cherryBlossom,
        error: SilkColors.dustyMauve,
        onError: SilkColors.light,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: SilkColors.dark,
    );
  }
}
