import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/gap.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';
import 'badge.dart';

class BadgeGap {
  static const double gap = SilkGap.sm;
  static const double iconSize = SilkTypography.md;

  static EdgeInsetsGeometry padding(BadgeScale scale) {
    switch (scale) {
      case BadgeScale.xs:
        return const EdgeInsets.symmetric(
          horizontal: SilkSpacing.md,
          vertical: SilkSpacing.xs,
        );
      case BadgeScale.sm:
        return const EdgeInsets.symmetric(
          horizontal: SilkSpacing.md,
          vertical: SilkSpacing.sm,
        );
      case BadgeScale.md:
        return const EdgeInsets.symmetric(
          horizontal: SilkGap.md,
          vertical: SilkSpacing.sm,
        );
      case BadgeScale.lg:
        return const EdgeInsets.symmetric(
          horizontal: SilkGap.md,
          vertical: SilkSpacing.md,
        );
    }
  }

  static double fontSize(BadgeScale scale) {
    switch (scale) {
      case BadgeScale.xs:
      case BadgeScale.sm:
        return SilkTypography.sm;
      case BadgeScale.md:
      case BadgeScale.lg:
        return SilkTypography.md;
    }
  }

  static double radius(bool isPill) {
    return isPill ? SilkBorder.radiusRound : SilkBorder.radiusMd;
  }
}
