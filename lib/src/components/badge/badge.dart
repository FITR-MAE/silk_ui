import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import 'gap.dart';

enum BadgeVariant { primary, secondary, destructive, outline }

enum BadgeScale { xs, sm, md, lg }

class SilkBadge extends StatelessWidget {
  final String label;
  final BadgeVariant variant;
  final BadgeScale scale;
  final bool isPill;
  final Widget? leading;

  const SilkBadge({
    super.key,
    required this.label,
    this.variant = BadgeVariant.primary,
    this.scale = BadgeScale.sm,
    this.isPill = false,
    this.leading,
  });

  bool _isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  Color _backgroundColor(BuildContext context) {
    final isDark = _isDark(context);
    switch (variant) {
      case BadgeVariant.primary:
        return SilkColors.dark;
      case BadgeVariant.secondary:
        return isDark ? SilkColors.grey : SilkColors.light;
      case BadgeVariant.destructive:
        return SilkColors.destructive;
      case BadgeVariant.outline:
        return Colors.transparent;
    }
  }

  Color _foregroundColor(BuildContext context) {
    final isDark = _isDark(context);
    switch (variant) {
      case BadgeVariant.primary:
      case BadgeVariant.destructive:
        return SilkColors.light;
      case BadgeVariant.secondary:
      case BadgeVariant.outline:
        return isDark ? SilkColors.light : SilkColors.dark;
    }
  }

  BorderSide? _border(BuildContext context) {
    if (variant != BadgeVariant.outline) {
      return null;
    }
    return BorderSide(
      color: _isDark(context) ? SilkColors.light : SilkColors.dark,
      width: SilkBorder.width,
      style: SilkBorder.style,
    );
  }

  @override
  Widget build(BuildContext context) {
    final foregroundColor = _foregroundColor(context);
    final border = _border(context);

    return Container(
      padding: BadgeGap.padding(scale),
      decoration: BoxDecoration(
        color: _backgroundColor(context),
        borderRadius: BorderRadius.circular(BadgeGap.radius(isPill)),
        border: border == null ? null : Border.fromBorderSide(border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading case final leading?) ...[
            IconTheme(
              data: IconThemeData(
                color: foregroundColor,
                size: BadgeGap.iconSize,
              ),
              child: leading,
            ),
            const SizedBox(width: BadgeGap.gap),
          ],
          Text(
            label,
            style: TextStyle(
              color: foregroundColor,
              fontSize: BadgeGap.fontSize(scale),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
