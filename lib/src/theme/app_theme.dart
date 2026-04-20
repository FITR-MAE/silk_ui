import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: SilkColors.dark,
        onPrimary: SilkColors.light,
        secondary: SilkColors.muted,
        onSecondary: SilkColors.dark,
        tertiary: SilkColors.accent,
        onTertiary: SilkColors.dark,
        surface: SilkColors.light,
        onSurface: SilkColors.dark,
        outline: SilkColors.border,
        error: SilkColors.destructive,
        onError: SilkColors.light,
      ),
      useMaterial3: true,
      fontFamily: SilkTypography.fontFamily,
      scaffoldBackgroundColor: SilkColors.light,
    );
  }

  static ThemeData get dark {
    return ThemeData(
      colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: SilkColors.light,
        onPrimary: SilkColors.dark,
        secondary: SilkColors.grey,
        onSecondary: SilkColors.light,
        tertiary: SilkColors.accent,
        onTertiary: SilkColors.dark,
        surface: SilkColors.dark,
        onSurface: SilkColors.light,
        outline: SilkColors.border,
        error: SilkColors.destructive,
        onError: SilkColors.light,
      ),
      useMaterial3: true,
      fontFamily: SilkTypography.fontFamily,
      scaffoldBackgroundColor: SilkColors.dark,
    );
  }
}
