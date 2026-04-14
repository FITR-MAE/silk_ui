import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

class SilkCard extends StatelessWidget {
  final Widget child;
  final double elevation;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  final Alignment align;

  const SilkCard({
    super.key,
    required this.child,
    this.elevation = CardSpacing.defaultElevation,
    this.borderRadius = CardSpacing.defaultBorderRadius,
    this.padding = const EdgeInsets.all(CardSpacing.defaultPadding),
    this.backgroundColor,
    this.align = Alignment.centerLeft,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = backgroundColor ?? theme.colorScheme.surface;
    return Material(
      color: surfaceColor,
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: elevation,
      child: Padding(
        padding: padding,
        child: Align(alignment: align, child: child),
      ),
    );
  }
}
