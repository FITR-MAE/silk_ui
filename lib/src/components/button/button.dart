import 'package:flutter/material.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/color_scheme.dart';
import '../../theme/shadow.dart';
import '../../theme/typography.dart';
import 'gap.dart';

enum ButtonVariant { primary, secondary, outline, ghost, accent, alt }

enum ButtonScale { xs, sm, md, lg }

class SilkButton extends StatefulWidget {
  final String label;
  final String? semanticLabel;
  final String? tooltip;
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
  final bool expand;

  const SilkButton({
    super.key,
    required this.label,
    this.semanticLabel,
    this.tooltip,
    this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.scale = ButtonScale.md,
    this.variant = ButtonVariant.primary,
    this.leading,
    this.trailing,
    this.backgroundColor,
    this.shadow = SilkShadow.none,
    this.borderRadius = SilkBorder.radiusMd,
    this.side,
    this.padding,
    this.expand = false,
  });

  @override
  State<SilkButton> createState() => _SilkButtonState();
}

class _SilkButtonState extends State<SilkButton> {
  bool _pressed = false;

  bool get _isInactive =>
      widget.isDisabled || widget.isLoading || widget.onPressed == null;

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    final bg = widget.backgroundColor ?? _backgroundColor(scheme);
    final fg = _foregroundColor(scheme);
    final border = _border(scheme, bg);

    final side = widget.side;
    final constraints = side == null
        ? const BoxConstraints(minHeight: 44)
        : BoxConstraints.tightFor(
            width: side < 44 ? 44 : side,
            height: side < 44 ? 44 : side,
          );
    Widget content = AnimatedContainer(
      duration: SilkAnimation.fast,
      curve: SilkAnimation.curve,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: border == null ? null : Border.fromBorderSide(border),
        boxShadow: widget.shadow.config.boxShadows,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: InkWell(
          onTap: _isInactive ? null : widget.onPressed,
          onHighlightChanged: (pressed) {
            if (_pressed != pressed) setState(() => _pressed = pressed);
          },
          borderRadius: BorderRadius.circular(widget.borderRadius),
          canRequestFocus: !_isInactive,
          excludeFromSemantics: true,
          child: Container(
            constraints: constraints,
            padding:
                widget.padding ??
                EdgeInsets.symmetric(
                  vertical: ButtonGap.paddingVertical(widget.scale),
                  horizontal: ButtonGap.paddingHorizontal(widget.scale),
                ),
            alignment: Alignment.center,
            child: IconTheme.merge(
              data: IconThemeData(color: fg),
              child: widget.isLoading
                  ? SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(fg),
                      ),
                    )
                  : _buildContent(fg),
            ),
          ),
        ),
      ),
    );

    Widget child = AnimatedScale(
      scale: _pressed ? 0.97 : 1.0,
      duration: SilkAnimation.fast,
      curve: SilkAnimation.spring,
      child: content,
    );

    if (widget.expand) {
      child = SizedBox(width: double.infinity, child: child);
    }

    child = AnimatedOpacity(
      duration: SilkAnimation.duration,
      opacity: _isInactive ? 0.5 : 1.0,
      child: Semantics(
        button: true,
        enabled: !_isInactive,
        label: widget.semanticLabel ?? widget.label,
        child: child,
      ),
    );
    if (widget.tooltip case final tooltip?) {
      child = Tooltip(message: tooltip, child: child);
    }
    return child;
  }

  Widget _buildContent(Color fg) {
    final children = <Widget?>[
      widget.leading,
      if (widget.label.isNotEmpty)
        Text(
          widget.label,
          style: TextStyle(
            fontWeight: SilkTypography.semibold,
            fontSize: ButtonGap.fontSize(widget.scale),
            color: fg,
            letterSpacing: SilkTypography.trackingNormal,
          ),
          textAlign: TextAlign.center,
        ),
      widget.trailing,
    ].whereType<Widget>().toList();

    if (children.length <= 1) {
      return children.isEmpty ? const SizedBox.shrink() : children.first;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(width: ButtonGap.content),
          children[i],
        ],
      ],
    );
  }

  Color _backgroundColor(SilkColorScheme scheme) {
    if (_isInactive) return scheme.muted;
    switch (widget.variant) {
      case ButtonVariant.primary:
        return scheme.primary;
      case ButtonVariant.accent:
        return scheme.accent;
      case ButtonVariant.secondary:
        return scheme.secondary;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
      case ButtonVariant.alt:
        return Colors.transparent;
    }
  }

  Color _foregroundColor(SilkColorScheme scheme) {
    if (_isInactive) return scheme.mutedForeground;
    switch (widget.variant) {
      case ButtonVariant.primary:
        return scheme.primaryForeground;
      case ButtonVariant.accent:
        return scheme.accentForeground;
      case ButtonVariant.secondary:
        return scheme.secondaryForeground;
      case ButtonVariant.outline:
      case ButtonVariant.ghost:
      case ButtonVariant.alt:
        return scheme.foreground;
    }
  }

  BorderSide? _border(SilkColorScheme scheme, Color bg) {
    switch (widget.variant) {
      case ButtonVariant.ghost:
      case ButtonVariant.alt:
        return null;
      case ButtonVariant.outline:
        return BorderSide(color: scheme.border, width: SilkBorder.width);
      case ButtonVariant.primary:
      case ButtonVariant.secondary:
      case ButtonVariant.accent:
        return BorderSide(color: bg, width: SilkBorder.width);
    }
  }
}
