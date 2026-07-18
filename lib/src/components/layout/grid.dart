import 'package:flutter/material.dart';

import '../../theme/spacing.dart';

enum GridValue { xs, sm, md, lg }

class _GridGap {
  static double spacing(GridValue value) {
    switch (value) {
      case GridValue.xs:
        return SilkSpacing.s1;
      case GridValue.sm:
        return SilkSpacing.s2;
      case GridValue.md:
        return SilkSpacing.s3;
      case GridValue.lg:
        return SilkSpacing.s4;
    }
  }
}

class SilkGrid extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final GridValue gap;
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
    this.gap = GridValue.md,
    this.mainAxisSpacing,
    this.crossAxisSpacing,
    this.childAspectRatio = 1,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
  });

  double get _spacing => _GridGap.spacing(gap);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing ?? _spacing,
      crossAxisSpacing: crossAxisSpacing ?? _spacing,
      childAspectRatio: childAspectRatio,
      padding: padding ?? EdgeInsets.all(SilkSpacing.md),
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: children,
    );
  }
}
