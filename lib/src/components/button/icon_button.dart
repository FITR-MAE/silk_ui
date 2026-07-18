import 'package:flutter/material.dart';

import '../../theme/shadow.dart';
import '../icon/icon.dart';
import 'button.dart';
import 'gap.dart';

class SilkIconButton extends SilkButton {
  final IconData icon;
  final Color? iconColor;

  SilkIconButton({
    super.key,
    required this.icon,
    required String label,
    this.iconColor,
    super.scale = ButtonScale.md,
    super.variant = ButtonVariant.primary,
    super.backgroundColor,
    super.borderRadius,
    super.shadow = SilkShadow.none,
    super.isLoading = false,
    super.isDisabled = false,
    super.onPressed,
    super.trailing,
    double? side,
    EdgeInsetsGeometry? padding,
  }) : super(
         label: '',
         semanticLabel: label,
         side: side ?? IconButtonGap.side(scale),
         padding: padding ?? EdgeInsets.zero,
         leading: _IconLeading(icon: icon, iconColor: iconColor, scale: scale),
       );
}

class _IconLeading extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final ButtonScale scale;

  const _IconLeading({
    required this.icon,
    required this.iconColor,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SilkIcon(
        icon: icon,
        size: IconButtonGap.iconSize(scale),
        color: iconColor,
      ),
    );
  }
}
