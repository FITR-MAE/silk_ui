import 'package:flutter/material.dart';
import '../../theme/spacing.dart';
import '../../theme/colors.dart';

class SilkButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonSize size;
  final ButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;

  const SilkButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = ButtonSize.md,
    this.variant = ButtonVariant.primary,
    this.leading,
    this.trailing,
    this.backgroundColor,
  });

  double get _paddingVertical {
    switch (size) {
      case ButtonSize.sm:
        return ButtonSpacing.paddingVerticalSm;
      case ButtonSize.md:
        return ButtonSpacing.paddingVerticalMd;
      case ButtonSize.lg:
        return ButtonSpacing.paddingVerticalLg;
    }
  }

  double get _paddingHorizontal {
    switch (size) {
      case ButtonSize.sm:
        return ButtonSpacing.paddingHorizontalSm;
      case ButtonSize.md:
        return ButtonSpacing.paddingHorizontalMd;
      case ButtonSize.lg:
        return ButtonSpacing.paddingHorizontalLg;
    }
  }

  double get _fontSize {
    switch (size) {
      case ButtonSize.sm:
        return ButtonSpacing.fontSizeSm;
      case ButtonSize.md:
        return ButtonSpacing.fontSizeMd;
      case ButtonSize.lg:
        return ButtonSpacing.fontSizeLg;
    }
  }

  TextStyle? get _textStyle {
    final baseStyle = TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: _fontSize,
    );

    switch (variant) {
      case ButtonVariant.primary:
        return baseStyle.copyWith(color: SilkColors.onPrimary);
      case ButtonVariant.secondary:
        return baseStyle.copyWith(color: SilkColors.onSecondary);
      case ButtonVariant.alt:
        return baseStyle.copyWith(color: SilkColors.outline);
    }
  }

  Color get _backgroundColor {
    if (isDisabled) {
      return SilkColors.disabled;
    }
    if (backgroundColor != null) {
      return backgroundColor!;
    }
    switch (variant) {
      case ButtonVariant.primary:
        return SilkColors.primary;
      case ButtonVariant.secondary:
        return SilkColors.secondary;
      case ButtonVariant.alt:
        return Colors.transparent;
    }
  }

  Color get _foregroundColor {
    if (isDisabled) {
      return SilkColors.onPrimary;
    }
    switch (variant) {
      case ButtonVariant.primary:
        return SilkColors.onPrimary;
      case ButtonVariant.secondary:
        return SilkColors.onSecondary;
      case ButtonVariant.alt:
        return SilkColors.outline;
    }
  }

  BorderSide? get _border {
    if (variant == ButtonVariant.alt) {
      return BorderSide(
        color: isDisabled ? SilkColors.disabled : SilkColors.outline,
        width: ButtonSpacing.borderWidth,
        style: ButtonSpacing.borderStyle,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: ButtonSpacing.animationDuration,
      opacity: isDisabled ? 0.6 : 1.0,
      child: Material(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(ButtonSpacing.borderRadius),
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(ButtonSpacing.borderRadius),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: _paddingVertical,
              horizontal: _paddingHorizontal,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ButtonSpacing.borderRadius),
              border: _border != null ? Border.fromBorderSide(_border!) : null,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _foregroundColor,
                      ),
                    ),
                  )
                : _buildContent(),
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (leading != null || trailing != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) leading!,
          if (leading != null && trailing != null) const SizedBox(width: 8),
          Text(label, style: _textStyle, textAlign: TextAlign.center),
          if (leading != null && trailing != null) const SizedBox(width: 8),
          if (trailing != null) trailing!,
        ],
      );
    }
    return Text(label, style: _textStyle, textAlign: TextAlign.center);
  }
}
