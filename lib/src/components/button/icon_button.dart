import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../theme/colors.dart';
import '../../theme/shadow.dart';
import 'button.dart';
import 'gap.dart';
import '../icon/icon.dart';

class SilkIconButton extends SilkButton {
  final PhosphorIconData icon;
  final Color? iconColor;

  SilkIconButton({
    super.key,
    required this.icon,
    this.iconColor,
    super.scale = ButtonScale.md,
    super.variant = ButtonVariant.primary,
    super.backgroundColor,
    super.shadow = SilkShadow.none,
    super.isLoading = false,
    super.isDisabled = false,
    super.onPressed,
  }) : super(
         label: '',
         side: IconButtonGap.side(scale),
         padding: EdgeInsets.zero,
         leading: _IconLeading(
           icon: icon,
           iconColor: iconColor,
           scale: scale,
           variant: variant,
           isDisabled: isDisabled,
         ),
       );
}

class _IconLeading extends StatelessWidget {
  final PhosphorIconData icon;
  final Color? iconColor;
  final ButtonScale scale;
  final ButtonVariant variant;
  final bool isDisabled;

  const _IconLeading({
    required this.icon,
    required this.iconColor,
    required this.scale,
    required this.variant,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SilkIcon(
        icon: icon,
        size: IconButtonGap.iconSize(scale),
        color: iconColor ?? _resolveIconColor(context),
      ),
    );
  }

  Color _resolveIconColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDisabled) {
      return isDark ? SilkColors.light : SilkColors.dark;
    }
    if (variant == ButtonVariant.primary) {
      return SilkColors.light;
    }
    return isDark ? SilkColors.light : SilkColors.dark;
  }
}
