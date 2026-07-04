import '../../theme/gap.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';
import 'button.dart';

class ButtonGap {
  static const double content = SilkGap.s2;

  static double paddingVertical(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return 6.0;
      case ButtonScale.sm:
        return 8.0;
      case ButtonScale.md:
        return 12.0;
      case ButtonScale.lg:
        return 16.0;
    }
  }

  static double paddingHorizontal(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return SilkSpacing.s3;
      case ButtonScale.sm:
        return SilkSpacing.s4;
      case ButtonScale.md:
        return SilkSpacing.s5;
      case ButtonScale.lg:
        return SilkSpacing.s6;
    }
  }

  static double fontSize(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
      case ButtonScale.sm:
        return SilkTypography.sm;
      case ButtonScale.md:
        return SilkTypography.md;
      case ButtonScale.lg:
        return SilkTypography.lg;
    }
  }
}

class IconButtonGap {
  static double iconSize(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return SilkSpacing.iconButtonIconXs;
      case ButtonScale.sm:
        return SilkSpacing.iconButtonIconSm;
      case ButtonScale.md:
        return SilkSpacing.iconButtonIconMd;
      case ButtonScale.lg:
        return SilkSpacing.iconButtonIconLg;
    }
  }

  static double side(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return SilkSpacing.iconButtonSideXs;
      case ButtonScale.sm:
        return SilkSpacing.iconButtonSideSm;
      case ButtonScale.md:
        return SilkSpacing.iconButtonSideMd;
      case ButtonScale.lg:
        return SilkSpacing.iconButtonSideLg;
    }
  }
}
