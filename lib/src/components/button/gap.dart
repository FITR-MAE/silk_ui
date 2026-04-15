import 'button.dart';
import '../../theme/gap.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

class ButtonGap {
  static const double content = SilkGap.sm;

  static double paddingVertical(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return SilkSpacing.xs;
      case ButtonScale.sm:
        return SilkSpacing.sm;
      case ButtonScale.md:
        return SilkSpacing.md;
      case ButtonScale.lg:
        return SilkSpacing.lg;
    }
  }

  static double paddingHorizontal(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return SilkSpacing.xs;
      case ButtonScale.sm:
        return SilkSpacing.md;
      case ButtonScale.md:
        return SilkSpacing.lg;
      case ButtonScale.lg:
        return SilkSpacing.lg;
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
