import 'package:flutter/material.dart';

import '../../components/button/button.dart';
import '../../components/button/gap.dart';
import '../../theme/border.dart';
import '../../theme/gap.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

class NavigationGap {
  static const double containerRadius = SilkBorder.radiusLg;
  static const double itemRadius = SilkBorder.radiusLg;
  static const double containerPadding = SilkSpacing.sm;
  static const double itemGap = SilkGap.sm;
  static const double fontSize = SilkTypography.xs;
  static const double sideWidthFactor = 0.75;
  static const double maxHeightFactor = 0.8;

  static EdgeInsetsGeometry get itemPadding => const EdgeInsets.symmetric(
    horizontal: SilkSpacing.md,
    vertical: SilkSpacing.sm,
  );

  static EdgeInsetsGeometry get drawerPadding => const EdgeInsets.all(SilkGap.lg);

  static double get tabHeight => IconButtonGap.side(ButtonScale.sm);

  static double get handleWidth => SilkGap.lg * 6;

  static double get handleHeight => SilkSpacing.md * 2;
}
