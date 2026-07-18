import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/color_scheme.dart';
import '../../theme/shadow.dart';
import 'gap.dart';

enum CardVariant { primary, secondary, elevated, ghost }

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
  final VoidCallback? onTap;
  final BorderSide? side;

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
    this.onTap,
    this.side,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    final radius = BorderRadius.circular(borderRadius);
    final shape = RoundedRectangleBorder(
      borderRadius: radius,
      side: _borderSide(scheme),
    );

    Widget content = Padding(
      padding: padding ?? EdgeInsets.all(CardGap.padding(scale)),
      child: DefaultTextStyle.merge(
        style: TextStyle(color: scheme.cardForeground),
        child: Align(alignment: align, child: child),
      ),
    );

    if (onTap != null) {
      content = InkWell(onTap: onTap, borderRadius: radius, child: content);
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: shadow.config.boxShadows,
      ),
      child: Material(
        color: backgroundColor ?? _backgroundColor(scheme),
        shape: shape,
        clipBehavior: Clip.antiAlias,
        child: content,
      ),
    );
  }

  Color _backgroundColor(SilkColorScheme scheme) {
    switch (variant) {
      case CardVariant.primary:
      case CardVariant.elevated:
        return scheme.card;
      case CardVariant.secondary:
        return scheme.muted;
      case CardVariant.ghost:
        return Colors.transparent;
    }
  }

  BorderSide _borderSide(SilkColorScheme scheme) {
    if (side != null) return side!;
    switch (variant) {
      case CardVariant.ghost:
        return BorderSide.none;
      case CardVariant.primary:
      case CardVariant.secondary:
      case CardVariant.elevated:
        return BorderSide(color: scheme.border, width: SilkBorder.width);
    }
  }
}
