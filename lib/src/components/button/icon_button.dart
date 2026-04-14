import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../theme/spacing.dart';
import '../../theme/colors.dart';

class SilkIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonSize size;
  final Color? backgroundColor;
  final Color? iconColor;

  const SilkIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.md,
    this.backgroundColor,
    this.iconColor,
  });

  double get _iconSize {
    switch (size) {
      case ButtonSize.sm:
        return ButtonSpacing.iconSizeSm;
      case ButtonSize.md:
        return ButtonSpacing.iconSizeMd;
      case ButtonSize.lg:
        return ButtonSpacing.iconSizeLg;
    }
  }

  double get _containerSize {
    switch (size) {
      case ButtonSize.sm:
        return ButtonSpacing.iconButtonSizeSm;
      case ButtonSize.md:
        return ButtonSpacing.iconButtonSizeMd;
      case ButtonSize.lg:
        return ButtonSpacing.iconButtonSizeLg;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: ButtonSpacing.animationDuration,
      opacity: isDisabled ? 0.6 : 1.0,
      child: Material(
        color: isDisabled
            ? SilkColors.disabled
            : (backgroundColor ?? SilkColors.primary),
        borderRadius: BorderRadius.circular(ButtonSpacing.borderRadius),
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(ButtonSpacing.borderRadius),
          child: Container(
            width: _containerSize,
            height: _containerSize,
            alignment: Alignment.center,
            child: isLoading
                ? SizedBox(
                    height: _iconSize,
                    width: _iconSize,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        iconColor ?? SilkColors.onPrimary,
                      ),
                    ),
                  )
                : Icon(
                    icon,
                    size: _iconSize,
                    color: iconColor ?? SilkColors.onPrimary,
                  ),
          ),
        ),
      ),
    );
  }
}
