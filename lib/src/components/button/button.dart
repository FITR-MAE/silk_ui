import 'package:flutter/material.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/shadow.dart';
import 'gap.dart';

enum ButtonVariant { primary, secondary, alt }

enum ButtonScale { xs, sm, md, lg }

class SilkButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isDisabled;
  final ButtonScale scale;
  final ButtonVariant variant;
  final Widget? leading;
  final Widget? trailing;
  final Color? backgroundColor;
  final SilkShadow shadow;
  final double borderRadius;
  final double? side;
  final EdgeInsetsGeometry? padding;

  const SilkButton({
    super.key,
    required this.label,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.scale = ButtonScale.md,
    this.variant = ButtonVariant.primary,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.shadow = SilkShadow.none,
    this.borderRadius = SilkBorder.radiusDefault,
    this.side,
    this.padding,
  });

  EdgeInsetsGeometry get _padding {
    return padding ??
        EdgeInsets.symmetric(
          vertical: ButtonGap.paddingVertical(scale),
          horizontal: ButtonGap.paddingHorizontal(scale),
        );
  }

  double get _fontSize => ButtonGap.fontSize(scale);

  ShadowConfig get _shadowConfig {
    switch (shadow) {
      case SilkShadow.xs:
        return ShadowConfig.xs;
      case SilkShadow.sm:
        return ShadowConfig.sm;
      case SilkShadow.md:
        return ShadowConfig.md;
      case SilkShadow.lg:
        return ShadowConfig.lg;
      case SilkShadow.none:
        return ShadowConfig.none;
    }
  }

  Color _foregroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDisabled) {
      return isDark ? SilkColors.light : SilkColors.dark;
    }
    if (variant == ButtonVariant.primary) {
      return SilkColors.light;
    }
    return isDark ? SilkColors.light : SilkColors.dark;
  }

  Color _disabledColor(BuildContext context) {
    return Theme.of(context).colorScheme.surfaceContainerHighest;
  }

  Color _themeBorderColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return isDark ? SilkColors.light : SilkColors.dark;
  }

  Color _backgroundColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    if (isDisabled) return _disabledColor(context);
    if (backgroundColor != null) return backgroundColor!;
    switch (variant) {
      case ButtonVariant.primary:
        return SilkColors.dark;
      case ButtonVariant.secondary:
        return isDark ? SilkColors.grey : Colors.transparent;
      case ButtonVariant.alt:
        return Colors.transparent;
    }
  }

  BorderSide? _border(BuildContext context) {
    if (variant == ButtonVariant.alt) {
      return null;
    }
    return BorderSide(
      color: isDisabled
          ? _disabledColor(context)
          : (variant == ButtonVariant.primary
                ? SilkColors.dark
                : _themeBorderColor(context)),
      width: SilkBorder.width,
      style: SilkBorder.style,
    );
  }

  @override
  Widget build(BuildContext context) {
    final shadowConfig = _shadowConfig;
    final border = _border(context);
    return AnimatedOpacity(
      duration: SilkAnimation.duration,
      opacity: isDisabled ? 0.6 : 1.0,
      child: Material(
        color: _backgroundColor(context),
        elevation: shadow == SilkShadow.none ? 0 : shadowConfig.elevation,
        shadowColor: shadowConfig.color,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: isDisabled || isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            constraints: side == null
                ? null
                : BoxConstraints.tightFor(width: side, height: side),
            padding: _padding,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: border == null ? null : Border.fromBorderSide(border),
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
    final textWidget = label.isEmpty
        ? null
        : Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: _fontSize,
              color: _foregroundColor(context),
            ),
            textAlign: TextAlign.center,
          );

    final children = <Widget>[
      if (leading case final leading?) leading,
      if (textWidget case final textWidget?) textWidget,
      if (trailing case final trailing?) trailing,
    ];

    if (children.length <= 1) {
      return children.isEmpty ? const SizedBox.shrink() : children.first;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var index = 0; index < children.length; index++) ...[
          if (index > 0) const SizedBox(width: ButtonGap.content),
          children[index],
        ],
      ],
    );
  }
}
