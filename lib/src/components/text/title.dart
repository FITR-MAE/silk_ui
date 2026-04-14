import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import 'gap.dart';

enum TitleScale { h1, h2, h3 }

class SilkTitle extends StatelessWidget {
  final String text;
  final TitleScale scale;
  final Color? color;
  final TextAlign textAlign;

  const SilkTitle({
    super.key,
    required this.text,
    this.scale = TitleScale.h1,
    this.color,
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
        fontWeight: FontWeight.bold,
        fontSize: TitleGap.fontSize(scale),
      ),
      textAlign: textAlign,
    );
  }
}
