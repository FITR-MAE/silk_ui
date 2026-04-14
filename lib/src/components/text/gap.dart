import 'text.dart';
import 'title.dart';

class TextGap {
  static double fontSize(TextScale scale) {
    switch (scale) {
      case TextScale.xs:
        return 10.0;
      case TextScale.sm:
        return 12.0;
      case TextScale.md:
        return 16.0;
      case TextScale.lg:
        return 20.0;
    }
  }
}

class TitleGap {
  static double fontSize(TitleScale scale) {
    switch (scale) {
      case TitleScale.h1:
        return 32.0;
      case TitleScale.h2:
        return 24.0;
      case TitleScale.h3:
        return 20.0;
    }
  }
}
