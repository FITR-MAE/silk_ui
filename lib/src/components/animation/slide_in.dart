import 'package:flutter/material.dart';

import '../../theme/animation.dart';

enum SlideDirection { up, down, left, right }

class SilkSlideIn extends StatefulWidget {
  final Widget child;
  final SlideDirection direction;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final double offset;

  const SilkSlideIn({
    super.key,
    required this.child,
    this.direction = SlideDirection.up,
    this.delay = Duration.zero,
    this.duration = SilkAnimation.duration,
    this.curve = SilkAnimation.easeOut,
    this.offset = 24.0,
  });

  @override
  State<SilkSlideIn> createState() => _SilkSlideInState();
}

class _SilkSlideInState extends State<SilkSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
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
      builder: (context, child) {
        final t = _controller.value;
        final dx =
            widget.direction == SlideDirection.left ||
            widget.direction == SlideDirection.right;
        final dy = !dx;
        final sign =
            widget.direction == SlideDirection.down ||
                widget.direction == SlideDirection.right
            ? -1.0
            : 1.0;
        return Opacity(
          opacity: t.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(
              dx ? sign * widget.offset * (1 - t) : 0,
              dy ? sign * widget.offset * (1 - t) : 0,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
