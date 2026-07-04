import 'package:flutter/material.dart';

/// Legacy static color constants (light palette only).
///
/// Prefer [SilkColorScheme.of(context)] for theme-aware resolution.
class SilkColors {
  static const Color dark = Color(0xFF0C0A09);
  static const Color light = Color(0xFFFAFAF9);
  static const Color grey = Color(0xFF78716C);
  static const Color destructive = Color(0xFFDC2626);

  static const Color powderPetal = Color(0xFFF5F5F4);
  static const Color cherryBlossom = Color(0xFF6366F1);
  static const Color alabasterGrey = Color(0xFFE7E5E4);
  static const Color pastelPink = Color(0xFFE0E7FF);
  static const Color dustyMauve = Color(0xFF818CF8);

  static const Color background = Color(0xFFFAFAF9);
  static const Color foreground = Color(0xFF1C1917);
  static const Color card = Color(0xFFFFFFFF);
  static const Color cardForeground = Color(0xFF1C1917);
  static const Color muted = Color(0xFFF5F5F4);
  static const Color mutedForeground = Color(0xFF78716C);
  static const Color border = Color(0xFFE7E5E4);
  static const Color input = Color(0xFFD6D3D1);
  static const Color ring = Color(0xFF6366F1);
  static const Color primary = Color(0xFF1C1917);
  static const Color primaryForeground = Color(0xFFFAFAF9);
  static const Color secondary = Color(0xFFF5F5F4);
  static const Color secondaryForeground = Color(0xFF1C1917);
  static const Color accent = Color(0xFF6366F1);
  static const Color accentForeground = Color(0xFFFFFFFF);
  static const Color destructiveForeground = Color(0xFFFFFFFF);
  static const Color success = Color(0xFF16A34A);
  static const Color warning = Color(0xFFD97706);

  static Color withAlpha(Color color, double alpha) =>
      color.withValues(alpha: alpha);
}
