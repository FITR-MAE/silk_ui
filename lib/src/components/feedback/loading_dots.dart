import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';

class SilkLoadingDots extends StatefulWidget {
  final double size;
  final Color? color;

  const SilkLoadingDots({super.key, this.size = 8.0, this.color});

  @override
  State<SilkLoadingDots> createState() => _SilkLoadingDotsState();
}

class _SilkLoadingDotsState extends State<SilkLoadingDots>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Timer> _delayTimers = [];
  bool? _disableAnimations;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    if (_disableAnimations == disableAnimations) return;
    _disableAnimations = disableAnimations;

    _stopAnimations();
    if (!disableAnimations) _startAnimations();
  }

  void _startAnimations() {
    _controllers.addAll(
      List.generate(3, (index) {
        return AnimationController(
          vsync: this,
          duration: const Duration(milliseconds: 600),
        );
      }),
    );

    for (var i = 0; i < _controllers.length; i++) {
      final controller = _controllers[i];
      if (i == 0) {
        controller.repeat(reverse: true);
        continue;
      }
      _delayTimers.add(
        Timer(Duration(milliseconds: i * 120), () {
          if (mounted && _controllers.contains(controller)) {
            controller.repeat(reverse: true);
          }
        }),
      );
    }
  }

  void _stopAnimations() {
    for (final timer in _delayTimers) {
      timer.cancel();
    }
    _delayTimers.clear();
    for (final controller in _controllers) {
      controller.dispose();
    }
    _controllers.clear();
  }

  @override
  void dispose() {
    _stopAnimations();
    super.dispose();
  }

  Widget _dot(Color color, double opacity) {
    return Container(
      width: widget.size,
      height: widget.size,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: opacity),
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ?? SilkColorScheme.of(context).mutedForeground;

    if (_controllers.isEmpty) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (_) => _dot(color, 0.7)),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final controller in _controllers)
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return _dot(color, 0.4 + (controller.value * 0.6));
            },
          ),
      ],
    );
  }
}
