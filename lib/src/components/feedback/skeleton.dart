import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/color_scheme.dart';

class SilkSkeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;
  final ShapeBorder? shape;

  const SilkSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = SilkBorder.radiusSm,
    this.shape,
  });

  const SilkSkeleton.circle({super.key, required double size})
    : width = size,
      height = size,
      borderRadius = 0,
      shape = const CircleBorder();

  @override
  State<SilkSkeleton> createState() => _SilkSkeletonState();
}

class _SilkSkeletonState extends State<SilkSkeleton>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  bool? _disableAnimations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (_disableAnimations == disableAnimations) return;
    _disableAnimations = disableAnimations;

    if (disableAnimations) {
      _controller?.dispose();
      _controller = null;
    } else {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 1400),
      )..repeat();
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    final controller = _controller;

    if (controller == null) {
      return _buildSkeleton(scheme, null);
    }

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => _buildSkeleton(scheme, controller.value),
    );
  }

  Widget _buildSkeleton(SilkColorScheme scheme, double? animationValue) {
    return Container(
      width: widget.width,
      height: widget.height ?? 16,
      decoration: ShapeDecoration(
        color: animationValue == null ? scheme.muted : null,
        gradient: animationValue == null
            ? null
            : LinearGradient(
                begin: Alignment(-1 + (animationValue * 2.5), 0),
                end: Alignment(-0.5 + (animationValue * 2.5), 0),
                colors: [scheme.muted, scheme.border, scheme.muted],
              ),
        shape:
            widget.shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
      ),
    );
  }
}
