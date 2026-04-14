import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

class SilkText extends StatelessWidget {
  final String text;
  final SilkTextSize size;
  final Color? color;
  final int? maxLines;

  const SilkText({
    super.key,
    required this.text,
    this.size = SilkTextSize.md,
    this.color,
    this.maxLines,
  });

  double get _fontSize {
    switch (size) {
      case SilkTextSize.sm:
        return TypographySpacing.textSm;
      case SilkTextSize.md:
        return TypographySpacing.textMd;
      case SilkTextSize.lg:
        return TypographySpacing.textLg;
    }
  }

  Color get _defaultColor {
    switch (size) {
      case SilkTextSize.sm:
        return TypographySpacing.textColorSm;
      case SilkTextSize.md:
        return TypographySpacing.textColorMd;
      case SilkTextSize.lg:
        return TypographySpacing.textColorLg;
    }
  }

  TextStyle get _style {
    return TextStyle(color: color ?? _defaultColor, fontSize: _fontSize);
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _style, maxLines: maxLines);
  }
}
