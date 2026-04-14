import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../theme/colors.dart';

class SilkCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;

  const SilkCard({
    super.key,
    required this.child,
    this.elevation = CardSpacing.defaultElevation,
    this.borderRadius = CardSpacing.defaultBorderRadius,
    this.padding = const EdgeInsets.all(CardSpacing.defaultPadding),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor ?? SilkColors.surface,
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: elevation,
      child: Padding(padding: padding, child: child),
    );
  }
}
