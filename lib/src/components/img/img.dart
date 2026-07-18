import 'package:flutter/material.dart';

import '../../theme/shadow.dart';

class SilkImage extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double borderRadius;
  final double? width;
  final double? height;
  final SilkShadow shadow;

  const SilkImage({
    super.key,
    required this.src,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.width,
    this.height,
    this.shadow = SilkShadow.none,
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
      case SilkShadow.xl:
        return ShadowConfig.xl;
      case SilkShadow.none:
        return ShadowConfig.none;
    }
  }

  bool get _isNetwork {
    return src.startsWith('http://') || src.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    Widget image;
    if (_isNetwork) {
      image = Image.network(
        src,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    } else {
      image = Image.asset(
        src,
        fit: fit,
        width: width,
        height: height,
        errorBuilder: (context, error, stackTrace) => Container(
          width: width,
          height: height,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey),
        ),
      );
    }

    final shadowConfig = _shadowConfig;

    if (borderRadius > 0) {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }

    if (shadow != SilkShadow.none) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius > 0
              ? BorderRadius.circular(borderRadius)
              : null,
          boxShadow: shadowConfig.boxShadows,
        ),
        child: image,
      );
    }

    return image;
  }
}
