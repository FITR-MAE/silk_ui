/// Canonical 4-point spacing grid.
///
/// Use [SilkSpacing] everywhere — [SilkGap] is a deprecated alias kept
/// only for backward compatibility with existing component code.
class SilkSpacing {
  static const double defaultValue = s4;

  // Canonical 4-pt grid
  static const double s0 = 0.0;
  static const double s1 = 4.0;
  static const double s2 = 8.0;
  static const double s3 = 12.0;
  static const double s4 = 16.0;
  static const double s5 = 20.0;
  static const double s6 = 24.0;
  static const double s8 = 32.0;
  static const double s10 = 40.0;
  static const double s12 = 48.0;
  static const double s16 = 64.0;
  static const double s20 = 80.0;
  static const double s24 = 96.0;

  // Legacy aliases (map to the grid above — do not use in new code)
  static const double none = s0;
  static const double xs = 1.0;
  static const double sm = 2.0;
  static const double md = 4.0;
  static const double lg = 8.0;

  // Icon-button sizing
  static const double iconButtonIconXs = 16.0;
  static const double iconButtonIconSm = 20.0;
  static const double iconButtonIconMd = 24.0;
  static const double iconButtonIconLg = 28.0;

  static const double iconButtonSideXs = 28.0;
  static const double iconButtonSideSm = 36.0;
  static const double iconButtonSideMd = 48.0;
  static const double iconButtonSideLg = 56.0;
}
