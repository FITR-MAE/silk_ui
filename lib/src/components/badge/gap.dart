import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';
import 'badge.dart';

class BadgeGap {
  static const double gap = SilkSpacing.s1;
  static const double iconSize = 14.0;

  static EdgeInsetsGeometry padding(BadgeScale scale) {
    switch (scale) {
      case BadgeScale.xs:
        return const EdgeInsets.symmetric(horizontal: 8, vertical: 3);
      case BadgeScale.sm:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 4);
      case BadgeScale.md:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case BadgeScale.lg:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
    }
  }

  static double fontSize(BadgeScale scale) {
    switch (scale) {
      case BadgeScale.xs:
        return 10.0;
      case BadgeScale.sm:
        return SilkTypography.xs;
      case BadgeScale.md:
        return SilkTypography.sm;
      case BadgeScale.lg:
        return SilkTypography.md;
    }
  }

  static double radius(bool isPill) {
    return isPill ? SilkBorder.radiusRound : SilkBorder.radiusSm;
  }
}
