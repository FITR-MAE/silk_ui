import 'package:flutter/material.dart';

import '../../theme/animation.dart';
import 'slide_in.dart';

class SilkStaggeredList extends StatelessWidget {
  final List<Widget> children;
  final Duration initialDelay;
  final Duration stepDelay;
  final SlideDirection direction;
  final double offset;
  final int maxStagger;

  const SilkStaggeredList({
    super.key,
    required this.children,
    this.initialDelay = Duration.zero,
    this.stepDelay = SilkAnimation.staggerStep,
    this.direction = SlideDirection.up,
    this.offset = 20.0,
    this.maxStagger = 6,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++)
          SilkSlideIn(
            delay:
                initialDelay + (stepDelay * (i < maxStagger ? i : maxStagger)),
            direction: direction,
            offset: offset,
            child: children[i],
          ),
      ],
    );
  }
}
