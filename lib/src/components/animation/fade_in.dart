import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/animation.dart';

class SilkFadeIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final double beginOpacity;

  const SilkFadeIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = SilkAnimation.duration,
    this.curve = SilkAnimation.easeOut,
    this.beginOpacity = 0.0,
  });

  @override
  State<SilkFadeIn> createState() => _SilkFadeInState();
}

class _SilkFadeInState extends State<SilkFadeIn>
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
    _animation = Tween<double>(
      begin: widget.beginOpacity,
      end: 1.0,
    ).animate(CurvedAnimation(parent: controller, curve: widget.curve));

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
        return IgnorePointer(
          ignoring: animation.value == 0,
          child: Opacity(opacity: animation.value, child: child),
        );
      },
      child: widget.child,
    );
  }
}
