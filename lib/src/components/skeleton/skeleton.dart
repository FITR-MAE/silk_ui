import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';

class SilkSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final ShapeBorder? shape;

  const SilkSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = SilkBorder.radiusMd,
    this.shape,
  });

  const SilkSkeleton.circle({
    super.key,
    required double size,
  })  : width = size,
        height = size,
        borderRadius = 0,
        shape = const CircleBorder();

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
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        final t = _controller.value;
        final color = Color.lerp(SilkColors.muted, SilkColors.accent, t)!;
        final shape = widget.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            );
        return SizedBox(
          width: widget.width,
          height: widget.height ?? 16,
          child: Material(color: color, shape: shape),
        );
      },
    );
  }
}
