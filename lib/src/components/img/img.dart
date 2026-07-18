import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';
import '../../theme/shadow.dart';

class SilkImage extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double borderRadius;
  final double? width;
  final double? height;
  final SilkShadow shadow;
  final String? semanticLabel;
  final bool excludeFromSemantics;

  const SilkImage({
    super.key,
    required this.src,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.width,
    this.height,
    this.shadow = SilkShadow.none,
    this.semanticLabel,
    this.excludeFromSemantics = false,
  });

  bool get _isNetwork {
    return src.startsWith('http://') || src.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    Widget image;
    if (_isNetwork) {
      image = Image.network(
        src,
        fit: fit,
        width: width,
        height: height,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        errorBuilder: (_, _, _) => _errorPlaceholder(scheme),
      );
    } else {
      image = Image.asset(
        src,
        fit: fit,
        width: width,
        height: height,
        semanticLabel: semanticLabel,
        excludeFromSemantics: excludeFromSemantics,
        errorBuilder: (_, _, _) => _errorPlaceholder(scheme),
      );
    }

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
          boxShadow: shadow.config.boxShadows,
        ),
        child: image,
      );
    }

    return image;
  }

  Widget _errorPlaceholder(SilkColorScheme scheme) {
    return ColoredBox(
      color: scheme.muted,
      child: SizedBox(
        width: width,
        height: height,
        child: Icon(Icons.broken_image, color: scheme.mutedForeground),
      ),
    );
  }
}
