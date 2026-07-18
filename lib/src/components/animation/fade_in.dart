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
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = Tween<double>(
      begin: widget.beginOpacity,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));

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
      animation: _animation,
      builder: (context, child) {
        return Opacity(opacity: _animation.value, child: child);
      },
      child: widget.child,
    );
  }
}
