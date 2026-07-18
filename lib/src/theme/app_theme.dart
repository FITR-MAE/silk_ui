import 'package:flutter/material.dart';

import 'border.dart';
import 'color_scheme.dart';
import 'typography.dart';

class AppTheme {
  static ThemeData get light => _build(SilkColorScheme.light, Brightness.light);
  static ThemeData get dark => _build(SilkColorScheme.dark, Brightness.dark);

  static ThemeData _build(SilkColorScheme scheme, Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: scheme.primary,
        onPrimary: scheme.primaryForeground,
        secondary: scheme.secondary,
        onSecondary: scheme.secondaryForeground,
        tertiary: scheme.accent,
        onTertiary: scheme.accentForeground,
        surface: scheme.background,
        onSurface: scheme.foreground,
        surfaceContainerHighest: scheme.muted,
        surfaceContainerLow: scheme.card,
        surfaceContainer: scheme.muted,
        outline: scheme.border,
        outlineVariant: scheme.border,
        error: scheme.destructive,
        onError: scheme.destructiveForeground,
        shadow: scheme.shadowColor,
        scrim: scheme.scrim,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: scheme.background,
      extensions: [scheme],
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.background,
        foregroundColor: scheme.foreground,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: scheme.foreground,
          fontSize: SilkTypography.lg,
          fontWeight: SilkTypography.semibold,
          letterSpacing: SilkTypography.trackingTight,
        ),
      ),
      textTheme: _textTheme(scheme),
      dividerTheme: DividerThemeData(
        color: scheme.border,
        thickness: SilkBorder.width,
        space: 1,
      ),
      splashColor: scheme.accent.withValues(alpha: 0.08),
      highlightColor: scheme.accent.withValues(alpha: 0.04),
      cardTheme: CardThemeData(
        color: scheme.card,
        elevation: 0,
        margin: EdgeInsets.zero,
      ),
      chipTheme: ChipThemeData(
        backgroundColor: scheme.muted,
        labelStyle: TextStyle(
          color: scheme.foreground,
          fontSize: SilkTypography.sm,
        ),
        side: BorderSide(color: scheme.border, width: SilkBorder.width),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SilkBorder.radiusRound),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: scheme.accent,
        circularTrackColor: scheme.muted,
      ),
      iconTheme: IconThemeData(color: scheme.foreground, size: 24),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: scheme.foreground,
        contentTextStyle: TextStyle(color: scheme.background),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SilkBorder.radiusMd),
        ),
      ),
    );
  }

  static TextTheme _textTheme(SilkColorScheme scheme) {
    return TextTheme(
      displayLarge: TextStyle(
        fontSize: SilkTypography.display,
        fontWeight: SilkTypography.bold,
        letterSpacing: SilkTypography.trackingTight,
        height: SilkTypography.tight,
        color: scheme.foreground,
      ),
      displayMedium: TextStyle(
        fontSize: SilkTypography.xxxl,
        fontWeight: SilkTypography.bold,
        letterSpacing: SilkTypography.trackingTight,
        height: SilkTypography.tight,
        color: scheme.foreground,
      ),
      headlineLarge: TextStyle(
        fontSize: SilkTypography.xxxl,
        fontWeight: SilkTypography.bold,
        letterSpacing: SilkTypography.trackingTight,
        height: SilkTypography.tight,
        color: scheme.foreground,
      ),
      headlineMedium: TextStyle(
        fontSize: SilkTypography.xxl,
        fontWeight: SilkTypography.semibold,
        letterSpacing: SilkTypography.trackingTight,
        height: SilkTypography.snug,
        color: scheme.foreground,
      ),
      titleLarge: TextStyle(
        fontSize: SilkTypography.xl,
        fontWeight: SilkTypography.semibold,
        color: scheme.foreground,
      ),
      titleMedium: TextStyle(
        fontSize: SilkTypography.lg,
        fontWeight: SilkTypography.semibold,
        color: scheme.foreground,
      ),
      bodyLarge: TextStyle(
        fontSize: SilkTypography.md,
        fontWeight: SilkTypography.normal,
        height: SilkTypography.relaxed,
        color: scheme.foreground,
      ),
      bodyMedium: TextStyle(
        fontSize: SilkTypography.sm,
        fontWeight: SilkTypography.normal,
        height: SilkTypography.normalLine,
        color: scheme.mutedForeground,
      ),
      bodySmall: TextStyle(
        fontSize: SilkTypography.xs,
        fontWeight: SilkTypography.normal,
        height: SilkTypography.normalLine,
        color: scheme.mutedForeground,
      ),
      labelLarge: TextStyle(
        fontSize: SilkTypography.sm,
        fontWeight: SilkTypography.semibold,
        letterSpacing: SilkTypography.trackingWide,
        color: scheme.foreground,
      ),
      labelSmall: TextStyle(
        fontSize: SilkTypography.xxs,
        fontWeight: SilkTypography.medium,
        letterSpacing: SilkTypography.trackingWide,
        color: scheme.mutedForeground,
      ),
    );
  }
}
