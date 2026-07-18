import 'package:flutter/material.dart';

import '../../theme/typography.dart';

class SilkHashtag extends StatelessWidget {
  final String tag;
  final Color? foregroundColor;
  final Color? backgroundColor;
  final Color? borderColor;

  const SilkHashtag({
    super.key,
    required this.tag,
    this.foregroundColor,
    this.backgroundColor,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final fg = foregroundColor ?? Colors.white.withValues(alpha: 0.9);
    final bg = backgroundColor ?? Colors.white.withValues(alpha: 0.1);
    final bc = borderColor ?? Colors.white.withValues(alpha: 0.25);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: bc),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: fg,
          fontSize: SilkTypography.sm,
          letterSpacing: 0.3,
        ),
      ),
    );
  }
}
