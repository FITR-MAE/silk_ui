import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import 'gap.dart';

enum TextScale { xs, sm, md, lg }

class SilkText extends StatelessWidget {
  final String text;
  final TextScale scale;
  final Color? color;
  final int? maxLines;
  final TextAlign textAlign;

  const SilkText({
    super.key,
    required this.text,
    this.scale = TextScale.md,
    this.color,
    this.maxLines,
    this.textAlign = TextAlign.start,
  });

  Color _defaultColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? SilkColors.light : SilkColors.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color ?? _defaultColor(context),
        fontSize: TextGap.fontSize(scale),
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
