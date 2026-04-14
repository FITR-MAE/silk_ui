import 'button.dart';
import '../../theme/spacing.dart';

class ButtonGap {
  static const double content = SilkSpacing.xs;

  static double paddingVertical(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return 6.0;
      case ButtonScale.sm:
        return SilkSpacing.xs;
      case ButtonScale.md:
        return SilkSpacing.sm;
      case ButtonScale.lg:
        return SilkSpacing.md;
    }
  }

  static double paddingHorizontal(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return 12.0;
      case ButtonScale.sm:
        return SilkSpacing.md;
      case ButtonScale.md:
        return SilkSpacing.lg;
      case ButtonScale.lg:
        return 32.0;
    }
  }

  static double fontSize(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return 11.0;
      case ButtonScale.sm:
        return 12.0;
      case ButtonScale.md:
        return 14.0;
      case ButtonScale.lg:
        return 16.0;
    }
  }
}

class IconButtonGap {
  static double iconSize(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return 16.0;
      case ButtonScale.sm:
        return 20.0;
      case ButtonScale.md:
        return 24.0;
      case ButtonScale.lg:
        return 28.0;
    }
  }

  static double side(ButtonScale scale) {
    switch (scale) {
      case ButtonScale.xs:
        return 28.0;
      case ButtonScale.sm:
        return 36.0;
      case ButtonScale.md:
        return 48.0;
      case ButtonScale.lg:
        return 56.0;
    }
  }
}
