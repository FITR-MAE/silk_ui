import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/shadow.dart';
import '../icon/icon.dart';
import 'button.dart';
import 'gap.dart';

class SilkImgButton extends SilkButton {
  final String? imgSrc;
  final Uint8List? imgBytes;
  final double? imgSize;
  final SilkShadow imgShadow;
  final IconData icon;
  final Color? iconColor;

  SilkImgButton({
    super.key,
    this.imgSrc,
    this.imgBytes,
    this.imgSize,
    this.imgShadow = SilkShadow.none,
    required this.icon,
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
    super.label = '',
  }) : super(
         side: side ?? IconButtonGap.side(scale),
         padding: padding ?? EdgeInsets.zero,
         leading: _ImgLeading(
           imgSrc: imgSrc,
           imgBytes: imgBytes,
           imgSize: (imgSize ?? IconButtonGap.iconSize(scale)) * 2,
           borderRadius: borderRadius,
           imgShadow: imgShadow,
           fallbackIcon: icon,
           iconColor: iconColor,
           scale: scale,
           variant: variant,
           isDisabled: isDisabled,
         ),
       );
}

class _ImgLeading extends StatelessWidget {
  final String? imgSrc;
  final Uint8List? imgBytes;
  final double imgSize;
  final SilkShadow imgShadow;
  final IconData fallbackIcon;
  final Color? iconColor;
  final ButtonScale scale;
  final ButtonVariant variant;
  final double borderRadius;
  final bool isDisabled;

  const _ImgLeading({
    this.imgSrc,
    this.imgBytes,
    required this.imgSize,
    required this.imgShadow,
    required this.fallbackIcon,
    required this.iconColor,
    required this.scale,
    required this.variant,
    required this.borderRadius,
    required this.isDisabled,
  });

  bool get _isNetwork =>
      imgSrc != null &&
      (imgSrc!.startsWith('http://') || imgSrc!.startsWith('https://'));

  bool get _hasBytes => imgBytes != null;
  bool get _hasSrc => imgSrc != null && imgSrc!.isNotEmpty;

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

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final iconColor = this.iconColor ?? _resolveIconColor(context);

    if (!_hasBytes && !_hasSrc) {
      return _buildPlaceholder(iconColor, isDark);
    }

    return Center(
      child: SizedBox(
        width: imgSize,
        height: imgSize,
        child: _hasBytes
            ? _buildMemoryImage(imgBytes!, iconColor, isDark)
            : _buildNetworkOrAssetImage(iconColor, isDark),
      ),
    );
  }

  Widget _buildMemoryImage(Uint8List bytes, Color iconColor, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.memory(
        bytes,
        fit: BoxFit.cover,
        width: imgSize,
        height: imgSize,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) =>
            _buildPlaceholder(iconColor, isDark),
      ),
    );
  }

  Widget _buildNetworkOrAssetImage(Color iconColor, bool isDark) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: _isNetwork
          ? _buildNetworkImage(iconColor, isDark)
          : _buildAssetImage(iconColor, isDark),
    );
  }

  Widget _buildNetworkImage(Color iconColor, bool isDark) {
    return Image.network(
      imgSrc!,
      fit: BoxFit.cover,
      width: imgSize,
      height: imgSize,
      cacheWidth: imgSize.toInt(),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildPlaceholder(iconColor, isDark);
      },
      errorBuilder: (context, error, stackTrace) =>
          _buildPlaceholder(iconColor, isDark),
    );
  }

  Widget _buildAssetImage(Color iconColor, bool isDark) {
    return Image.asset(
      imgSrc!,
      fit: BoxFit.cover,
      width: imgSize,
      height: imgSize,
      cacheWidth: imgSize.toInt(),
      errorBuilder: (context, error, stackTrace) =>
          _buildPlaceholder(iconColor, isDark),
    );
  }

  Widget _buildPlaceholder(Color iconColor, bool isDark) {
    return Center(
      child: SilkIcon(
        icon: fallbackIcon,
        size: IconButtonGap.iconSize(scale),
        color: iconColor,
      ),
    );
  }
}
