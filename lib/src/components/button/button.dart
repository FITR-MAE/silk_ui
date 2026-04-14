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

  Color _primaryColor(BuildContext context) {
    final theme = Theme.of(context);
    final themeBrightness = theme.brightness;
    return themeBrightness == Brightness.dark
        ? theme.colorScheme.primary
        : SilkColors.primary;
  }

  Color _secondaryColor(BuildContext context) {
    final theme = Theme.of(context);
    final themeBrightness = theme.brightness;
    return themeBrightness == Brightness.dark
        ? theme.colorScheme.secondary
        : SilkColors.secondary;
  }

  Color _onPrimaryColor(BuildContext context) {
    final theme = Theme.of(context);
    final themeBrightness = theme.brightness;
    return themeBrightness == Brightness.dark
        ? theme.colorScheme.onPrimary
        : SilkColors.onPrimary;
  }

  Color _onSecondaryColor(BuildContext context) {
    final theme = Theme.of(context);
    final themeBrightness = theme.brightness;
    return themeBrightness == Brightness.dark
        ? theme.colorScheme.onSecondary
        : SilkColors.onSecondary;
  }

  Color _outlineColor(BuildContext context) {
    final theme = Theme.of(context);
    final themeBrightness = theme.brightness;
    return themeBrightness == Brightness.dark
        ? theme.colorScheme.outline
        : SilkColors.outline;
  }

  Color _disabledColor(BuildContext context) {
    final theme = Theme.of(context);
    return theme.colorScheme.surfaceContainerHighest;
  }

  Color _backgroundColor(BuildContext context) {
    if (isDisabled) return _disabledColor(context);
    if (backgroundColor != null) return backgroundColor!;
    switch (variant) {
      case ButtonVariant.primary:
        return _primaryColor(context);
      case ButtonVariant.secondary:
        return _secondaryColor(context);
      case ButtonVariant.alt:
        return Colors.transparent;
    }
  }

  Color _foregroundColor(BuildContext context) {
    if (isDisabled) return _onPrimaryColor(context);
    switch (variant) {
      case ButtonVariant.primary:
        return _onPrimaryColor(context);
      case ButtonVariant.secondary:
        return _onSecondaryColor(context);
      case ButtonVariant.alt:
        return _outlineColor(context);
    }
  }

  BorderSide? _border(BuildContext context) {
    if (variant == ButtonVariant.alt) {
      return BorderSide(
        color: isDisabled ? _disabledColor(context) : _outlineColor(context),
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
        color: _backgroundColor(context),
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
              border: _border(context) != null
                  ? Border.fromBorderSide(_border(context)!)
                  : null,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        _foregroundColor(context),
                      ),
                    ),
                  )
                : _buildContent(context),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (leading != null || trailing != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading case final leading?) leading,
          if (leading != null && trailing != null) const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: _fontSize,
              color: _foregroundColor(context),
            ),
            textAlign: TextAlign.center,
          ),
          if (leading != null && trailing != null) const SizedBox(width: 8),
          if (trailing case final trailing?) trailing,
        ],
      );
    }
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: _fontSize,
        color: _foregroundColor(context),
      ),
      textAlign: TextAlign.center,
    );
  }
}
