import 'card.dart';
import '../../theme/spacing.dart';

class CardGap {
  static double padding(CardScale scale) {
    switch (scale) {
      case CardScale.xs:
        return SilkSpacing.xs;
      case CardScale.sm:
        return SilkSpacing.sm;
      case CardScale.md:
        return SilkSpacing.md;
      case CardScale.lg:
        return SilkSpacing.lg;
    }
  }
}
