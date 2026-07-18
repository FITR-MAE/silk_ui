import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/spacing.dart';

class NavigationGap {
  /// Outer container radius.
  static const double containerRadius = SilkBorder.radius2Xl;

  /// Selected-item pill radius — smaller than container for nested look.
  static const double itemRadius = SilkBorder.radiusMd;

  /// Inner padding inside the container around the tabs.
  static const double containerPadding = SilkSpacing.s1;

  /// Bottom margin from the screen edge (plus SafeArea).
  static const double bottomMargin = SilkSpacing.s3;

  /// Horizontal margin from the screen edges.
  static const double sideMargin = SilkSpacing.s4;

  static const double fontSize = 11.0;
  static const double tabHeight = 52.0;
  static const double iconSize = 22.0;

  // Drawer-related metrics (used by SilkDrawer)
  static const double sideWidthFactor = 0.75;
  static const double sideMaxWidth = 420;
  static const double maxHeightFactor = 0.8;

  static EdgeInsetsGeometry get itemPadding => const EdgeInsets.symmetric(
    horizontal: SilkSpacing.s4,
    vertical: SilkSpacing.s2,
  );

  static const EdgeInsetsGeometry drawerPadding = EdgeInsets.all(
    SilkSpacing.s4,
  );

  static const double handleWidth = SilkSpacing.s6 * 2.5;

  static const double handleHeight = SilkSpacing.s1;
}
