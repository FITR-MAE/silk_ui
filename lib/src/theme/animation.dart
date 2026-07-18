import 'package:flutter/animation.dart';

class SilkAnimation {
  static const Duration instant = Duration(milliseconds: 80);
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration duration = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 400);
  static const Duration slower = Duration(milliseconds: 600);

  static const Curve curve = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOutCubic;
  static const Curve easeIn = Curves.easeInCubic;
  static const Curve spring = Curves.fastOutSlowIn;
  static const Curve overshoot = Curves.easeOutBack;
  static const Curve bounce = Curves.elasticOut;
  static const Curve smooth = Curves.decelerate;

  static const Duration staggerStep = Duration(milliseconds: 40);
}
