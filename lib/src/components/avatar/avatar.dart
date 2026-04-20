import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/typography.dart';

enum AvatarScale { xs, sm, md, lg, xl }

class SilkAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final AvatarScale scale;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onTap;

  const SilkAvatar({
    super.key,
    this.imageUrl,
    this.name,
    this.scale = AvatarScale.md,
    this.backgroundColor,
    this.foregroundColor,
    this.onTap,
  });

  double get _size {
    switch (scale) {
      case AvatarScale.xs:
        return 24.0;
      case AvatarScale.sm:
        return 32.0;
      case AvatarScale.md:
        return 40.0;
      case AvatarScale.lg:
        return 56.0;
      case AvatarScale.xl:
        return 80.0;
    }
  }

  double get _fontSize {
    switch (scale) {
      case AvatarScale.xs:
        return SilkTypography.xs;
      case AvatarScale.sm:
        return SilkTypography.sm;
      case AvatarScale.md:
        return SilkTypography.md;
      case AvatarScale.lg:
        return SilkTypography.lg;
      case AvatarScale.xl:
        return SilkTypography.xxl;
    }
  }

  String get _initials {
    final source = name?.trim();
    if (source == null || source.isEmpty) return '?';
    final parts = source.split(RegExp(r'\s+')).where((p) => p.isNotEmpty).toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first.characters.first.toUpperCase();
    return (parts.first.characters.first + parts.last.characters.first).toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final size = _size;
    final bg = backgroundColor ?? SilkColors.muted;
    final fg = foregroundColor ?? SilkColors.mutedForeground;

    Widget content;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      content = ClipOval(
        child: Image.network(
          imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _initialsWidget(bg, fg, size),
        ),
      );
    } else {
      content = _initialsWidget(bg, fg, size);
    }

    if (onTap != null) {
      content = GestureDetector(onTap: onTap, child: content);
    }
    return SizedBox(width: size, height: size, child: content);
  }

  Widget _initialsWidget(Color bg, Color fg, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        _initials,
        style: TextStyle(
          color: fg,
          fontSize: _fontSize,
          fontWeight: FontWeight.w500,
          fontFamily: SilkTypography.fontFamily,
        ),
      ),
    );
  }
}
