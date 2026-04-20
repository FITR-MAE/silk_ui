import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/typography.dart';

enum InputScale { sm, md, lg }

class SilkInput extends StatelessWidget {
  final TextEditingController? controller;
  final String? initialValue;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final Widget? leading;
  final Widget? trailing;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final VoidCallback? onTap;
  final FocusNode? focusNode;
  final InputScale scale;

  const SilkInput({
    super.key,
    this.controller,
    this.initialValue,
    this.hintText,
    this.labelText,
    this.errorText,
    this.leading,
    this.trailing,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.focusNode,
    this.scale = InputScale.md,
  });

  double get _fontSize {
    switch (scale) {
      case InputScale.sm:
        return SilkTypography.sm;
      case InputScale.md:
        return SilkTypography.md;
      case InputScale.lg:
        return SilkTypography.lg;
    }
  }

  EdgeInsets get _contentPadding {
    switch (scale) {
      case InputScale.sm:
        return const EdgeInsets.symmetric(horizontal: 10, vertical: 8);
      case InputScale.md:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
      case InputScale.lg:
        return const EdgeInsets.symmetric(horizontal: 14, vertical: 14);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final hasError = errorText != null && errorText!.isNotEmpty;
    final fillColor = SilkColors.inputBackground;
    final textColor = isDark ? SilkColors.light : SilkColors.dark;
    final hintColor = SilkColors.mutedForeground;
    final borderColor = hasError ? SilkColors.destructive : SilkColors.border;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(SilkBorder.radiusLg),
      borderSide: BorderSide(color: borderColor, width: SilkBorder.width),
    );
    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(SilkBorder.radiusLg),
      borderSide: BorderSide(
        color: hasError ? SilkColors.destructive : SilkColors.dark,
        width: SilkBorder.width,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelText != null) ...[
          Text(
            labelText!,
            style: TextStyle(
              color: textColor,
              fontSize: SilkTypography.sm,
              fontWeight: FontWeight.w500,
              fontFamily: SilkTypography.fontFamily,
            ),
          ),
          const SizedBox(height: 6),
        ],
        TextFormField(
          controller: controller,
          initialValue: controller == null ? initialValue : null,
          focusNode: focusNode,
          enabled: enabled,
          readOnly: readOnly,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          minLines: minLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          onTap: onTap,
          style: TextStyle(
            color: textColor,
            fontSize: _fontSize,
            fontFamily: SilkTypography.fontFamily,
          ),
          decoration: InputDecoration(
            isDense: true,
            filled: true,
            fillColor: fillColor,
            hintText: hintText,
            hintStyle: TextStyle(
              color: hintColor,
              fontSize: _fontSize,
              fontFamily: SilkTypography.fontFamily,
            ),
            prefixIcon: leading,
            suffixIcon: trailing,
            contentPadding: _contentPadding,
            counterText: '',
            border: border,
            enabledBorder: border,
            focusedBorder: focusedBorder,
            disabledBorder: border,
            errorBorder: border.copyWith(
              borderSide: const BorderSide(color: SilkColors.destructive),
            ),
            focusedErrorBorder: focusedBorder,
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Text(
            errorText!,
            style: const TextStyle(
              color: SilkColors.destructive,
              fontSize: SilkTypography.sm,
              fontFamily: SilkTypography.fontFamily,
            ),
          ),
        ],
      ],
    );
  }
}
