import 'package:flutter/material.dart';

import '../../theme/gap.dart';

enum StackOrientation { vertical, horizontal }

enum StackGap { xs, sm, md, lg }

class StackGapUtil {
  static double spacing(StackGap value) {
    switch (value) {
      case StackGap.xs:
        return SilkGap.sm;
      case StackGap.sm:
        return SilkGap.md;
      case StackGap.md:
        return SilkGap.lg;
      case StackGap.lg:
        return SilkGap.lg;
    }
  }
}

class SilkStack extends StatelessWidget {
  final List<Widget> children;
  final StackGap gap;
  final StackOrientation orientation;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;

  const SilkStack({
    super.key,
    required this.children,
    this.gap = StackGap.md,
    this.orientation = StackOrientation.vertical,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    final spacedChildren = <Widget>[];
    for (var index = 0; index < children.length; index++) {
      if (index > 0) {
        spacedChildren.add(
          orientation == StackOrientation.vertical
              ? SizedBox(height: StackGapUtil.spacing(gap))
              : SizedBox(width: StackGapUtil.spacing(gap)),
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
