import 'package:flutter/material.dart';

import '../../theme/spacing.dart';

enum StackOrientation { vertical, horizontal }

enum StackValue { sm, md, lg }

class StackGap {
  static double spacing(StackValue value) {
    switch (value) {
      case StackValue.sm:
        return SilkSpacing.xs;
      case StackValue.md:
        return SilkSpacing.md;
      case StackValue.lg:
        return SilkSpacing.lg;
    }
  }
}

class SilkStack extends StatelessWidget {
  final List<Widget> children;
  final StackValue value;
  final StackOrientation orientation;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const SilkStack({
    super.key,
    required this.children,
    this.value = StackValue.md,
    this.orientation = StackOrientation.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  double get _spacing => StackGap.spacing(value);

  @override
  Widget build(BuildContext context) {
    final spacedChildren = <Widget>[];
    for (var index = 0; index < children.length; index++) {
      if (index > 0) {
        spacedChildren.add(
          orientation == StackOrientation.vertical
              ? SizedBox(height: _spacing)
              : SizedBox(width: _spacing),
        );
      }
      spacedChildren.add(children[index]);
    }

    return Flex(
      direction: orientation == StackOrientation.vertical
          ? Axis.vertical
          : Axis.horizontal,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: spacedChildren,
    );
  }
}
