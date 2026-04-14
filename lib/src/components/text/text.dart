import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

class SilkText extends StatelessWidget {
  final String text;
  final SilkTextSize size;
  final Color? color;
  final int? maxLines;
  final TextAlign textAlign;

  const SilkText({
    super.key,
    required this.text,
    this.size = SilkTextSize.md,
    this.color,
    this.maxLines,
    this.textAlign = TextAlign.start,
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    Color? resolvedColor;
    if (color != null) {
      resolvedColor = color;
    } else {
      TextStyle? themeStyle;
      switch (size) {
        case SilkTextSize.sm:
          themeStyle = textTheme.bodySmall;
        case SilkTextSize.md:
          themeStyle = textTheme.bodyMedium;
        case SilkTextSize.lg:
          themeStyle = textTheme.bodyLarge;
      }
      resolvedColor = themeStyle?.color ?? _defaultColor;
    }

    return Text(
      text,
      style: TextStyle(color: resolvedColor, fontSize: _fontSize),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
