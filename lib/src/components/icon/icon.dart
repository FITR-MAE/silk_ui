import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SilkIcon extends StatelessWidget {
  final PhosphorIconData icon;
  final double? size;
  final Color? color;

  const SilkIcon({super.key, required this.icon, this.size, this.color});

  @override
  Widget build(BuildContext context) {
    return PhosphorIcon(icon, size: size, color: color);
  }
}
