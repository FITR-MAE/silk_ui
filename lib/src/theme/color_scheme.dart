import 'package:flutter/material.dart';

/// Resolved, theme-aware color tokens.
///
/// Registered as a [ThemeExtension] on both [AppTheme.light] and [AppTheme.dark].
/// Components resolve via `SilkColorScheme.of(context)` — never branch on
/// brightness directly.
@immutable
class SilkColorScheme extends ThemeExtension<SilkColorScheme> {
  final Color background;
  final Color foreground;
  final Color card;
  final Color cardForeground;
  final Color muted;
  final Color mutedForeground;
  final Color border;
  final Color input;
  final Color ring;
  final Color primary;
  final Color primaryForeground;
  final Color secondary;
  final Color secondaryForeground;
  final Color accent;
  final Color accentForeground;
  final Color destructive;
  final Color destructiveForeground;
  final Color success;
  final Color warning;
  final Color shadowColor;
  final Color scrim;

  const SilkColorScheme._({
    required this.background,
    required this.foreground,
    required this.card,
    required this.cardForeground,
    required this.muted,
    required this.mutedForeground,
    required this.border,
    required this.input,
    required this.ring,
    required this.primary,
    required this.primaryForeground,
    required this.secondary,
    required this.secondaryForeground,
    required this.accent,
    required this.accentForeground,
    required this.destructive,
    required this.destructiveForeground,
    required this.success,
    required this.warning,
    required this.shadowColor,
    required this.scrim,
  });

  /// Light palette — warm stone neutrals with indigo accent.
  static const light = SilkColorScheme._(
    background: Color(0xFFFAFAF9),
    foreground: Color(0xFF1C1917),
    card: Color(0xFFFFFFFF),
    cardForeground: Color(0xFF1C1917),
    muted: Color(0xFFF5F5F4),
    mutedForeground: Color(0xFF78716C),
    border: Color(0xFFE7E5E4),
    input: Color(0xFFD6D3D1),
    ring: Color(0xFF6366F1),
    primary: Color(0xFF1C1917),
    primaryForeground: Color(0xFFFAFAF9),
    secondary: Color(0xFFF5F5F4),
    secondaryForeground: Color(0xFF1C1917),
    accent: Color(0xFF6366F1),
    accentForeground: Color(0xFFFFFFFF),
    destructive: Color(0xFFDC2626),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF16A34A),
    warning: Color(0xFFD97706),
    shadowColor: Color(0x0A000000),
    scrim: Color(0x66000000),
  );

  /// Dark palette — true near-black with elevated surfaces.
  static const dark = SilkColorScheme._(
    background: Color(0xFF0C0A09),
    foreground: Color(0xFFFAFAF9),
    card: Color(0xFF1C1917),
    cardForeground: Color(0xFFFAFAF9),
    muted: Color(0xFF292524),
    mutedForeground: Color(0xFFA8A29E),
    border: Color(0xFF292524),
    input: Color(0xFF44403C),
    ring: Color(0xFF818CF8),
    primary: Color(0xFFFAFAF9),
    primaryForeground: Color(0xFF1C1917),
    secondary: Color(0xFF292524),
    secondaryForeground: Color(0xFFFAFAF9),
    accent: Color(0xFF818CF8),
    accentForeground: Color(0xFF1C1917),
    destructive: Color(0xFFEF4444),
    destructiveForeground: Color(0xFFFFFFFF),
    success: Color(0xFF22C55E),
    warning: Color(0xFFFBBF24),
    shadowColor: Color(0x20000000),
    scrim: Color(0x99000000),
  );

  static SilkColorScheme of(BuildContext context) {
    final theme = Theme.of(context);
    return theme.extension<SilkColorScheme>() ??
        (theme.brightness == Brightness.dark ? dark : light);
  }

  @override
  SilkColorScheme copyWith({
    Color? background,
    Color? foreground,
    Color? card,
    Color? cardForeground,
    Color? muted,
    Color? mutedForeground,
    Color? border,
    Color? input,
    Color? ring,
    Color? primary,
    Color? primaryForeground,
    Color? secondary,
    Color? secondaryForeground,
    Color? accent,
    Color? accentForeground,
    Color? destructive,
    Color? destructiveForeground,
    Color? success,
    Color? warning,
    Color? shadowColor,
    Color? scrim,
  }) {
    return SilkColorScheme._(
      background: background ?? this.background,
      foreground: foreground ?? this.foreground,
      card: card ?? this.card,
      cardForeground: cardForeground ?? this.cardForeground,
      muted: muted ?? this.muted,
      mutedForeground: mutedForeground ?? this.mutedForeground,
      border: border ?? this.border,
      input: input ?? this.input,
      ring: ring ?? this.ring,
      primary: primary ?? this.primary,
      primaryForeground: primaryForeground ?? this.primaryForeground,
      secondary: secondary ?? this.secondary,
      secondaryForeground: secondaryForeground ?? this.secondaryForeground,
      accent: accent ?? this.accent,
      accentForeground: accentForeground ?? this.accentForeground,
      destructive: destructive ?? this.destructive,
      destructiveForeground:
          destructiveForeground ?? this.destructiveForeground,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      shadowColor: shadowColor ?? this.shadowColor,
      scrim: scrim ?? this.scrim,
    );
  }

  @override
  SilkColorScheme lerp(SilkColorScheme? other, double t) {
    if (other == null) return this;
    return SilkColorScheme._(
      background: Color.lerp(background, other.background, t)!,
      foreground: Color.lerp(foreground, other.foreground, t)!,
      card: Color.lerp(card, other.card, t)!,
      cardForeground: Color.lerp(cardForeground, other.cardForeground, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      mutedForeground: Color.lerp(mutedForeground, other.mutedForeground, t)!,
      border: Color.lerp(border, other.border, t)!,
      input: Color.lerp(input, other.input, t)!,
      ring: Color.lerp(ring, other.ring, t)!,
      primary: Color.lerp(primary, other.primary, t)!,
      primaryForeground: Color.lerp(
        primaryForeground,
        other.primaryForeground,
        t,
      )!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      secondaryForeground: Color.lerp(
        secondaryForeground,
        other.secondaryForeground,
        t,
      )!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentForeground: Color.lerp(
        accentForeground,
        other.accentForeground,
        t,
      )!,
      destructive: Color.lerp(destructive, other.destructive, t)!,
      destructiveForeground: Color.lerp(
        destructiveForeground,
        other.destructiveForeground,
        t,
      )!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      scrim: Color.lerp(scrim, other.scrim, t)!,
    );
  }
}
