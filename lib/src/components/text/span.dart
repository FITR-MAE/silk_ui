import 'package:flutter/material.dart';

class SilkSpan extends StatelessWidget {
  final String text;
  final FontStyle? fontStyle;
  final FontWeight? fontWeight;
  final TextDecoration? textDecoration;
  final Color? color;
  final int? maxLines;

  const SilkSpan({
    super.key,
    required this.text,
    this.fontStyle,
    this.fontWeight,
    this.textDecoration,
    this.color,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        decoration: textDecoration,
        color: color,
      ),
      maxLines: maxLines,
    );
  }
}
