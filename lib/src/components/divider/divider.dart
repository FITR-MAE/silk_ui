import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/color_scheme.dart';

class SilkDivider extends StatelessWidget {
  final double thickness;
  final double indent;
  final double endIndent;
  final Color? color;

  const SilkDivider({
    super.key,
    this.thickness = SilkBorder.width,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    return Divider(
      height: 1,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: color ?? scheme.border,
    );
  }
}
