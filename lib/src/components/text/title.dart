import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';
import '../../theme/typography.dart';
import 'gap.dart';

enum TitleScale { h1, h2, h3 }

class SilkTitle extends StatelessWidget {
  final String text;
  final TitleScale scale;
  final Color? color;
  final TextAlign textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const SilkTitle({
    super.key,
    required this.text,
    this.scale = TitleScale.h1,
    this.color,
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    return Semantics(
      header: true,
      child: Text(
        text,
        style: TextStyle(
          color: color ?? scheme.foreground,
          fontSize: TitleGap.fontSize(scale),
          fontWeight: TitleGap.weight(scale),
          letterSpacing: TitleGap.letterSpacing(scale),
          height: SilkTypography.tight,
        ),
        maxLines: maxLines,
        textAlign: textAlign,
        overflow: overflow,
      ),
    );
  }
}
