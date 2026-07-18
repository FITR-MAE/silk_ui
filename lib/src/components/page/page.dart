import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';
import '../../theme/spacing.dart';
import '../animation/fade_in.dart';

class SilkPage extends StatelessWidget {
  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool animate;
  final EdgeInsets padding;
  final bool avoidBottomInset;
  final Color? backgroundColor;

  const SilkPage({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.animate = true,
    this.padding = const EdgeInsets.symmetric(horizontal: SilkSpacing.s4),
    this.avoidBottomInset = true,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    final content = SafeArea(
      child: Padding(padding: padding, child: body),
    );

    return Scaffold(
      backgroundColor: backgroundColor ?? scheme.background,
      appBar: appBar,
      body: animate ? SilkFadeIn(child: content) : content,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: avoidBottomInset,
    );
  }
}
