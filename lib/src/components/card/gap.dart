import '../../theme/spacing.dart';
import 'card.dart';

class CardGap {
  static double padding(CardScale scale) {
    switch (scale) {
      case CardScale.xs:
        return SilkSpacing.s3;
      case CardScale.sm:
        return SilkSpacing.s4;
      case CardScale.md:
        return SilkSpacing.s4;
      case CardScale.lg:
        return SilkSpacing.s5;
    }
  }
}
