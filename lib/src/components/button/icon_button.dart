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
         leading: _IconLeading(
           icon: icon,
           iconColor: iconColor,
           size: size,
           variant: variant,
           isDisabled: isDisabled,
         ),
       );
}

class _IconLeading extends StatelessWidget {
  final PhosphorIconData icon;
  final Color? iconColor;
  final ButtonSize size;
  final ButtonVariant variant;
  final bool isDisabled;

  const _IconLeading({
    required this.icon,
    required this.iconColor,
    required this.size,
    required this.variant,
    required this.isDisabled,
  });

  @override
  Widget build(BuildContext context) {
    return SilkIcon(
      icon: icon,
      size: _iconSizeFor(size),
      color: iconColor ?? _resolveIconColor(context),
    );
  }

  Color _resolveIconColor(BuildContext context) {
    final theme = Theme.of(context);
    final themeBrightness = theme.brightness;
    if (isDisabled) {
      return theme.colorScheme.surfaceContainerHighest;
    }
    if (variant == ButtonVariant.primary) {
      return themeBrightness == Brightness.dark
          ? theme.colorScheme.onPrimary
          : SilkColors.onPrimary;
    } else if (variant == ButtonVariant.secondary) {
      return themeBrightness == Brightness.dark
          ? theme.colorScheme.onSecondary
          : SilkColors.onSecondary;
    }
    return themeBrightness == Brightness.dark
        ? theme.colorScheme.outline
        : SilkColors.outline;
  }

  static double _iconSizeFor(ButtonSize size) {
    switch (size) {
      case ButtonSize.sm:
        return ButtonSpacing.iconSizeSm;
      case ButtonSize.md:
        return ButtonSpacing.iconSizeMd;
      case ButtonSize.lg:
        return ButtonSpacing.iconSizeLg;
    }
  }
}
