import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../theme/spacing.dart';
import '../../theme/colors.dart';
import 'button.dart';
import '../icon/icon.dart';

class SilkIconButton extends SilkButton {
  final PhosphorIconData icon;
  final Color? iconColor;

  SilkIconButton({
    super.key,
    required this.icon,
    this.iconColor,
    super.size = ButtonSize.md,
    super.variant = ButtonVariant.primary,
    super.isLoading = false,
    super.isDisabled = false,
    super.onPressed,
  }) : super(
         label: '',
         leading: SilkIcon(
           icon: icon,
           size: size == ButtonSize.sm
               ? ButtonSpacing.iconSizeSm
               : size == ButtonSize.md
               ? ButtonSpacing.iconSizeMd
               : ButtonSpacing.iconSizeLg,
           color: iconColor ?? SilkColors.onPrimary,
         ),
       );
}
