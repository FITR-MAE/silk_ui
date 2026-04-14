import 'package:flutter/material.dart';

class SilkImage extends StatelessWidget {
  final String src;
  final BoxFit fit;
  final double borderRadius;
  final double? width;
  final double? height;

  const SilkImage({
    super.key,
    required this.src,
    this.fit = BoxFit.cover,
    this.borderRadius = 0.0,
    this.width,
    this.height,
  });

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

    if (borderRadius > 0) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: image,
      );
    }

    return image;
  }
}
