import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/shadow.dart';
import 'gap.dart';

enum CardVariant { primary, secondary }

enum CardScale { xs, sm, md, lg }

class SilkCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Alignment align;
  final SilkShadow shadow;
  final CardVariant variant;
  final CardScale scale;

  const SilkCard({
    super.key,
    required this.child,
    this.borderRadius = SilkBorder.radiusMd,
    this.padding,
    this.backgroundColor,
    this.align = Alignment.centerLeft,
    this.shadow = SilkShadow.none,
    this.variant = CardVariant.primary,
    this.scale = CardScale.md,
  });

  ShadowConfig get _shadowConfig {
    switch (shadow) {
      case SilkShadow.xs:
        return ShadowConfig.xs;
      case SilkShadow.sm:
        return ShadowConfig.sm;
      case SilkShadow.md:
        return ShadowConfig.md;
      case SilkShadow.lg:
        return ShadowConfig.lg;
      case SilkShadow.none:
        return ShadowConfig.none;
    }
  }

  Color _backgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (variant) {
      case CardVariant.primary:
        return Colors.transparent;
      case CardVariant.secondary:
        return isDark ? SilkColors.grey : Colors.transparent;
    }
  }

  Color _themeBorderColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? SilkColors.light : SilkColors.dark;
  }

  Color _textColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? SilkColors.light : SilkColors.dark;
  }

  @override
  Widget build(BuildContext context) {
    final shadowConfig = _shadowConfig;
    return Material(
      color: backgroundColor ?? _backgroundColor(context),
      elevation: shadow == SilkShadow.none ? 0 : shadowConfig.elevation,
      shadowColor: shadow == SilkShadow.none ? null : shadowConfig.color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide(
          color: _themeBorderColor(context),
          width: SilkBorder.width,
        ),
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.all(CardGap.padding(scale)),
        child: DefaultTextStyle(
          style: TextStyle(color: _textColor(context)),
          child: Align(alignment: align, child: child),
        ),
      ),
    );
  }
}
