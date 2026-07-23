import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/color_scheme.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';
import 'gap.dart';

enum SilkDrawerPlacement { bottom, left, right }

class SilkDrawer extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? description;
  final Widget? footer;
  final SilkDrawerPlacement placement;
  final bool showHandle;
  final EdgeInsetsGeometry? padding;

  const SilkDrawer({
    super.key,
    required this.child,
    this.title,
    this.description,
    this.footer,
    this.placement = SilkDrawerPlacement.bottom,
    this.showHandle = true,
    this.padding,
  });

  static Future<T?> show<T>(
    BuildContext context, {
    required Widget child,
    String? title,
    String? description,
    Widget? footer,
    SilkDrawerPlacement placement = SilkDrawerPlacement.bottom,
    bool isDismissible = true,
    bool enableDrag = true,
    bool showHandle = true,
  }) {
    final disableAnimations = MediaQuery.disableAnimationsOf(context);
    final transitionDuration = disableAnimations
        ? Duration.zero
        : SilkAnimation.duration;
    switch (placement) {
      case SilkDrawerPlacement.bottom:
        return showModalBottomSheet<T>(
          context: context,
          isDismissible: isDismissible,
          enableDrag: enableDrag,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          sheetAnimationStyle: disableAnimations
              ? const AnimationStyle(
                  duration: Duration.zero,
                  reverseDuration: Duration.zero,
                )
              : null,
          builder: (context) => SilkDrawer(
            title: title,
            description: description,
            footer: footer,
            placement: placement,
            showHandle: showHandle,
            child: child,
          ),
        );
      case SilkDrawerPlacement.left:
      case SilkDrawerPlacement.right:
        return showGeneralDialog<T>(
          context: context,
          barrierDismissible: isDismissible,
          barrierLabel: 'Close drawer',
          barrierColor: SilkColorScheme.of(context).scrim,
          transitionDuration: transitionDuration,
          pageBuilder: (context, animation, secondaryAnimation) =>
              _DrawerDialog(
                title: title,
                description: description,
                footer: footer,
                placement: placement,
                child: child,
              ),
          transitionBuilder: (context, animation, _, page) {
            if (disableAnimations) return page;
            final begin = placement == SilkDrawerPlacement.left
                ? const Offset(-1, 0)
                : const Offset(1, 0);
            return SlideTransition(
              position: Tween<Offset>(
                begin: begin,
                end: Offset.zero,
              ).animate(animation),
              child: page,
            );
          },
        );
    }
  }

  BorderRadiusGeometry _borderRadius() {
    switch (placement) {
      case SilkDrawerPlacement.bottom:
        return const BorderRadius.only(
          topLeft: Radius.circular(SilkBorder.radiusLg),
          topRight: Radius.circular(SilkBorder.radiusLg),
        );
      case SilkDrawerPlacement.left:
        return const BorderRadius.only(
          topRight: Radius.circular(SilkBorder.radiusLg),
          bottomRight: Radius.circular(SilkBorder.radiusLg),
        );
      case SilkDrawerPlacement.right:
        return const BorderRadius.only(
          topLeft: Radius.circular(SilkBorder.radiusLg),
          bottomLeft: Radius.circular(SilkBorder.radiusLg),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);
    final maxHeight = placement == SilkDrawerPlacement.bottom
        ? MediaQuery.sizeOf(context).height * NavigationGap.maxHeightFactor
        : null;

    return SafeArea(
      top: placement != SilkDrawerPlacement.bottom,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight ?? double.infinity),
        child: Material(
          color: scheme.card,
          shape: RoundedRectangleBorder(
            borderRadius: _borderRadius(),
            side: BorderSide(
              color: scheme.border,
              width: SilkBorder.width,
              style: SilkBorder.style,
            ),
          ),
          child: Padding(
            padding: padding ?? NavigationGap.drawerPadding,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (placement == SilkDrawerPlacement.bottom && showHandle)
                  Align(
                    child: Container(
                      width: NavigationGap.handleWidth,
                      height: NavigationGap.handleHeight,
                      margin: const EdgeInsets.only(bottom: SilkSpacing.s4),
                      decoration: BoxDecoration(
                        color: scheme.mutedForeground,
                        borderRadius: BorderRadius.circular(
                          SilkBorder.radiusRound,
                        ),
                      ),
                    ),
                  ),
                if (title != null || description != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: SilkSpacing.s3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title case final title?)
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: SilkTypography.md,
                              fontWeight: FontWeight.w600,
                              color: scheme.foreground,
                            ),
                          ),
                        if (description case final description?)
                          Padding(
                            padding: const EdgeInsets.only(top: SilkSpacing.s1),
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: SilkTypography.sm,
                                color: scheme.mutedForeground,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                Flexible(
                  fit: placement == SilkDrawerPlacement.bottom
                      ? FlexFit.loose
                      : FlexFit.tight,
                  child: child,
                ),
                if (footer case final footer?) ...[
                  const SizedBox(height: SilkSpacing.s3),
                  footer,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerDialog extends StatelessWidget {
  final Widget child;
  final String? title;
  final String? description;
  final Widget? footer;
  final SilkDrawerPlacement placement;

  const _DrawerDialog({
    required this.child,
    required this.title,
    required this.description,
    required this.footer,
    required this.placement,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Material(
      color: Colors.transparent,
      child: Align(
        alignment: placement == SilkDrawerPlacement.left
            ? Alignment.centerLeft
            : Alignment.centerRight,
        child: SizedBox(
          width: math.min(
            size.width * NavigationGap.sideWidthFactor,
            NavigationGap.sideMaxWidth,
          ),
          height: size.height,
          child: SilkDrawer(
            title: title,
            description: description,
            footer: footer,
            placement: placement,
            showHandle: false,
            child: child,
          ),
        ),
      ),
    );
  }
}
