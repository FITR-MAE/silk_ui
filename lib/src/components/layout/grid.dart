import 'package:flutter/material.dart';

import '../../theme/spacing.dart';

enum GridValue { sm, md, lg }

class GridGap {
  static double spacing(GridValue value) {
    switch (value) {
      case GridValue.sm:
        return SilkSpacing.xs;
      case GridValue.md:
        return SilkSpacing.md;
      case GridValue.lg:
        return SilkSpacing.lg;
    }
  }
}

class SilkGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final GridValue value;
  final double? mainAxisSpacing;
  final double? crossAxisSpacing;
  final double childAspectRatio;
  final EdgeInsetsGeometry? padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const SilkGrid({
    super.key,
    required this.children,
    this.crossAxisCount = 2,
    this.value = GridValue.md,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.childAspectRatio = 1,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  double get _spacing => GridGap.spacing(value);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing ?? _spacing,
      crossAxisSpacing: crossAxisSpacing ?? _spacing,
      childAspectRatio: childAspectRatio,
      padding: padding ?? EdgeInsets.all(_spacing),
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: children,
    );
  }
}
