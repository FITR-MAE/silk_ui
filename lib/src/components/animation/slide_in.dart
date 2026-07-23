import 'dart:async';

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
  AnimationController? _controller;
  Animation<double>? _animation;
  Timer? _delayTimer;
  bool? _disableAnimations;
  bool _finished = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (_disableAnimations == disableAnimations) return;
    _disableAnimations = disableAnimations;

    if (disableAnimations) {
      _finishImmediately();
    } else if (!_finished) {
      _startAnimation();
    }
  }

  void _startAnimation() {
    final controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _controller = controller;
    _animation = CurvedAnimation(parent: controller, curve: widget.curve);
    if (widget.delay == Duration.zero) {
      controller.forward();
    } else {
      _delayTimer = Timer(widget.delay, controller.forward);
    }
  }

  void _finishImmediately() {
    _finished = true;
    _delayTimer?.cancel();
    _delayTimer = null;
    _controller?.dispose();
    _controller = null;
    _animation = null;
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animation = _animation;
    if (_disableAnimations == true || animation == null) return widget.child;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final t = animation.value;
        final dx =
            widget.direction == SlideDirection.left ||
            widget.direction == SlideDirection.right;
        final dy = !dx;
        final sign =
            widget.direction == SlideDirection.down ||
                widget.direction == SlideDirection.right
            ? -1.0
            : 1.0;
        return IgnorePointer(
          ignoring: t == 0,
          child: Opacity(
            opacity: t.clamp(0.0, 1.0),
            child: Transform.translate(
              offset: Offset(
                dx ? sign * widget.offset * (1 - t) : 0,
                dy ? sign * widget.offset * (1 - t) : 0,
              ),
              child: child,
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
