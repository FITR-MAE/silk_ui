import 'package:flutter/material.dart';

enum SilkShadow { none, xs, sm, md, lg }

class ShadowConfig {
  final double elevation;
  final Color? color;

  const ShadowConfig({required this.elevation, this.color});

  static const ShadowConfig none = ShadowConfig(elevation: 0);

  static const ShadowConfig xs = ShadowConfig(
    elevation: 1,
    color: Color(0x14000000),
  );

  static const ShadowConfig sm = ShadowConfig(
    elevation: 2,
    color: Color(0x1A000000),
  );

  static const ShadowConfig md = ShadowConfig(
    elevation: 4,
    color: Color(0x29000000),
  );

  static const ShadowConfig lg = ShadowConfig(
    elevation: 8,
    color: Color(0x3D000000),
  );
}
