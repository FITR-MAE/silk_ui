import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class SilkLoadingDots extends StatefulWidget {
  final double size;
  final Color? color;

  const SilkLoadingDots({super.key, this.size = 8.0, this.color});

  @override
  State<SilkLoadingDots> createState() => _SilkLoadingDotsState();
}

class _SilkLoadingDotsState extends State<SilkLoadingDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(3, (index) {
      return AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      );
    });

    for (var i = 0; i < _controllers.length; i++) {
      Future<void>.delayed(Duration(milliseconds: i * 120), () {
        if (mounted) {
          _controllers[i].repeat(reverse: true);
        }
      });
    }
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color =
        widget.color ??
        (isDark ? SilkColors.light : SilkColors.mutedForeground);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final controller in _controllers)
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Container(
                width: widget.size,
                height: widget.size,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: color.withValues(
                    alpha: 0.4 + (controller.value * 0.6),
                  ),
                  shape: BoxShape.circle,
                ),
              );
            },
          ),
      ],
    );
  }
}
