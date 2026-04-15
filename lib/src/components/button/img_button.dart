import 'package:flutter/material.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/shadow.dart';
import 'button.dart';
import 'gap.dart';

class SilkImgButton extends StatelessWidget {
  final String imgSrc;
  final VoidCallback? onPressed;
  final bool isDisabled;
  final double size;
  final SilkShadow shadow;

  const SilkImgButton({
    super.key,
    required this.imgSrc,
    this.onPressed,
    this.isDisabled = false,
    this.size = 48.0,
    this.shadow = SilkShadow.sm,
  });

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

  bool get _isNetwork {
    return imgSrc.startsWith('http://') || imgSrc.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final shadowConfig = _shadowConfig;

    Widget image;
    if (_isNetwork) {
      image = Image.network(
        imgSrc,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    } else {
      image = Image.asset(
        imgSrc,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    }

    return AnimatedOpacity(
      duration: SilkAnimation.duration,
      opacity: isDisabled ? 0.6 : 1.0,
      child: Material(
        color: Colors.transparent,
        elevation: shadow == SilkShadow.none ? 0 : shadowConfig.elevation,
        shadowColor: shadowConfig.color,
        borderRadius: BorderRadius.circular(SilkBorder.radiusDefault),
        child: InkWell(
          onTap: isDisabled ? null : onPressed,
          borderRadius: BorderRadius.circular(SilkBorder.radiusDefault),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SilkBorder.radiusDefault),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(SilkBorder.radiusDefault),
              child: image,
            ),
          ),
        ),
      ),
    );
  }
}
