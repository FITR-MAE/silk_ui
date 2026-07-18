import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';
import '../../theme/typography.dart';
import 'gap.dart';

enum TextScale { xs, sm, md, lg }

class SilkText extends StatelessWidget {
  final String text;
  final TextScale scale;
  final Color? color;
  final int? maxLines;
  final TextAlign textAlign;
  final FontWeight? fontWeight;
  final double? height;
  final TextOverflow? overflow;

  const SilkText({
    super.key,
    required this.text,
    this.scale = TextScale.md,
    this.color,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.fontWeight,
    this.height,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    return Text(
      text,
      style: TextStyle(
        color: color ?? scheme.foreground,
        fontSize: TextGap.fontSize(scale),
        fontWeight: fontWeight ?? SilkTypography.normal,
        height: height ?? TextGap.lineHeight(scale),
        letterSpacing: SilkTypography.trackingNormal,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: overflow,
    );
  }
}
