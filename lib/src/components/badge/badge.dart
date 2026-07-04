import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/color_scheme.dart';
import '../../theme/typography.dart';
import 'gap.dart';

enum BadgeVariant { primary, secondary, accent, outline, destructive, success }

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
    this.variant = BadgeVariant.secondary,
    this.scale = BadgeScale.sm,
    this.isPill = true,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    final bg = _backgroundColor(scheme);
    final fg = _foregroundColor(scheme);
    final border = _border(scheme);

    return Container(
      padding: BadgeGap.padding(scale),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(BadgeGap.radius(isPill)),
        border: border == null ? null : Border.fromBorderSide(border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading case final leading?) ...[
            IconTheme(
              data: IconThemeData(color: fg, size: BadgeGap.iconSize),
              child: leading,
            ),
            const SizedBox(width: BadgeGap.gap),
          ],
          Text(
            label,
            style: TextStyle(
              color: fg,
              fontSize: BadgeGap.fontSize(scale),
              fontWeight: SilkTypography.medium,
              letterSpacing: SilkTypography.trackingWide,
            ),
          ),
        ],
      ),
    );
  }

  Color _backgroundColor(SilkColorScheme scheme) {
    switch (variant) {
      case BadgeVariant.primary:
        return scheme.primary;
      case BadgeVariant.secondary:
        return scheme.muted;
      case BadgeVariant.accent:
        return scheme.accent;
      case BadgeVariant.destructive:
        return scheme.destructive;
      case BadgeVariant.success:
        return scheme.success;
      case BadgeVariant.outline:
        return Colors.transparent;
    }
  }

  Color _foregroundColor(SilkColorScheme scheme) {
    switch (variant) {
      case BadgeVariant.primary:
        return scheme.primaryForeground;
      case BadgeVariant.secondary:
        return scheme.foreground;
      case BadgeVariant.accent:
        return scheme.accentForeground;
      case BadgeVariant.destructive:
        return scheme.destructiveForeground;
      case BadgeVariant.success:
        return Colors.white;
      case BadgeVariant.outline:
        return scheme.foreground;
    }
  }

  BorderSide? _border(SilkColorScheme scheme) {
    if (variant != BadgeVariant.outline) return null;
    return BorderSide(color: scheme.border, width: SilkBorder.width);
  }
}
