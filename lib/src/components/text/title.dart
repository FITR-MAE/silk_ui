import 'package:flutter/material.dart';
import '../../theme/spacing.dart';

class SilkTitle extends StatelessWidget {
  final String text;
  final SilkTitleLevel level;
  final Color? color;

  const SilkTitle({
    super.key,
    required this.text,
    this.level = SilkTitleLevel.h1,
    this.color,
  });

  double get _fontSize {
    switch (level) {
      case SilkTitleLevel.h1:
        return TypographySpacing.titleH1;
      case SilkTitleLevel.h2:
        return TypographySpacing.titleH2;
      case SilkTitleLevel.h3:
        return TypographySpacing.titleH3;
    }
  }

  TextStyle get _style {
    return TextStyle(
      color: color,
      fontWeight: FontWeight.bold,
      fontSize: _fontSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: _style);
  }
}
