import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/color_scheme.dart';

class SilkSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;

  const SilkSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = SilkBorder.radiusSm,
  });

  @override
  State<SilkSkeleton> createState() => _SilkSkeletonState();
}

class _SilkSkeletonState extends State<SilkSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1 + (_controller.value * 2.5), 0),
              end: Alignment(-0.5 + (_controller.value * 2.5), 0),
              colors: [scheme.muted, scheme.border, scheme.muted],
            ),
          ),
        );
      },
    );
  }
}
