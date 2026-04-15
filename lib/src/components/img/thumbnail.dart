import 'package:flutter/material.dart';

import '../../theme/shadow.dart';

class SilkThumbnail extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double borderRadius;
  final double size;
  final SilkShadow shadow;

  const SilkThumbnail({
    super.key,
    required this.src,
    this.fit = BoxFit.cover,
    this.borderRadius = 8.0,
    this.size = 80.0,
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
        width: size,
        height: size,
        cacheWidth: (size * 2).toInt(),
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey, size: 32),
        ),
      );
    } else {
      image = Image.asset(
        src,
        fit: fit,
        width: size,
        height: size,
        cacheWidth: (size * 2).toInt(),
        errorBuilder: (context, error, stackTrace) => Container(
          width: size,
          height: size,
          color: Colors.grey[300],
          child: const Icon(Icons.broken_image, color: Colors.grey, size: 32),
        ),
      );
    }

    final shadowConfig = _shadowConfig;

    image = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: image,
    );

    if (shadow != SilkShadow.none) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: shadowConfig.color ?? Colors.transparent,
              blurRadius: shadowConfig.elevation * 2,
              offset: Offset(0, shadowConfig.elevation),
            ),
          ],
        ),
        child: image,
      );
    }

    return image;
  }
}
