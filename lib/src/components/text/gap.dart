import 'text.dart';
import '../../theme/typography.dart';
import 'title.dart';

// TODO: --> TextFontSize (move to typography.dart)
class TextGap {
  static double fontSize(TextScale scale) {
    switch (scale) {
      case TextScale.xs:
      case TextScale.sm:
        return SilkTypography.sm;
      case TextScale.md:
        return SilkTypography.md;
      case TextScale.lg:
        return SilkTypography.lg;
    }
  }
}

// TODO: --> TitleFontSize (move to typography.dart)
class TitleGap {
  static double fontSize(TitleScale scale) {
    switch (scale) {
      case TitleScale.h1:
        return SilkTypography.md * 2;
      case TitleScale.h2:
        return SilkTypography.sm * 2;
      case TitleScale.h3:
        return SilkTypography.lg;
    }
  }
}
