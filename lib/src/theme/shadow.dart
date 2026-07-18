import 'package:flutter/material.dart';

enum SilkShadow { none, xs, sm, md, lg, xl }

extension SilkShadowX on SilkShadow {
  ShadowConfig get config {
    switch (this) {
      case SilkShadow.none:
        return ShadowConfig.none;
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
    }
  }
}

class ShadowConfig {
  final List<BoxShadow> boxShadows;

  const ShadowConfig({required this.boxShadows});

  static const ShadowConfig none = ShadowConfig(boxShadows: []);

  static const ShadowConfig xs = ShadowConfig(
    boxShadows: [
      BoxShadow(color: Color(0x08000000), blurRadius: 2, offset: Offset(0, 1)),
    ],
  );

  static const ShadowConfig sm = ShadowConfig(
    boxShadows: [
      BoxShadow(color: Color(0x0A000000), blurRadius: 4, offset: Offset(0, 2)),
      BoxShadow(color: Color(0x05000000), blurRadius: 1, offset: Offset(0, 1)),
    ],
  );

  static const ShadowConfig md = ShadowConfig(
    boxShadows: [
      BoxShadow(color: Color(0x0D000000), blurRadius: 8, offset: Offset(0, 4)),
      BoxShadow(color: Color(0x06000000), blurRadius: 3, offset: Offset(0, 2)),
    ],
  );

  static const ShadowConfig lg = ShadowConfig(
    boxShadows: [
      BoxShadow(color: Color(0x10000000), blurRadius: 16, offset: Offset(0, 8)),
      BoxShadow(color: Color(0x08000000), blurRadius: 6, offset: Offset(0, 4)),
    ],
  );

  static const ShadowConfig xl = ShadowConfig(
    boxShadows: [
      BoxShadow(
        color: Color(0x14000000),
        blurRadius: 28,
        offset: Offset(0, 16),
      ),
      BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 6)),
    ],
  );

  double get elevation {
    if (boxShadows.isEmpty) return 0;
    return boxShadows.first.offset.dy;
  }

  Color? get color {
    if (boxShadows.isEmpty) return null;
    return boxShadows.first.color;
  }
}
