import 'dart:ui';

import 'package:flutter/material.dart';

import '../../theme/animation.dart';
import '../../theme/border.dart';
import '../../theme/color_scheme.dart';
import '../../theme/shadow.dart';
import '../../theme/typography.dart';
import 'gap.dart';

class SilkTabNavigationItem {
  final String? label;
  final IconData? icon;
  final IconData? selectedIcon;

  const SilkTabNavigationItem({this.label, this.icon, this.selectedIcon})
    : assert(label != null || icon != null);
}

class SilkTabNavigation extends StatefulWidget {
  final List<SilkTabNavigationItem> items;
  final List<Widget> pages;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final bool keepPagesMounted;

  /// Optional external controller. If provided, the caller owns the controller
  /// and is responsible for disposing it. [initialIndex] is ignored.
  final TabController? controller;

  const SilkTabNavigation({
    super.key,
    required this.items,
    required this.pages,
    this.initialIndex = 0,
    this.onChanged,
    this.keepPagesMounted = true,
    this.controller,
  }) : assert(items.length == pages.length);

  @override
  State<SilkTabNavigation> createState() => _SilkTabNavigationState();
}

class _SilkTabNavigationState extends State<SilkTabNavigation>
    with SingleTickerProviderStateMixin {
  TabController? _internalController;

  TabController get _controller => widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _internalController = TabController(
        length: widget.items.length,
        initialIndex: widget.initialIndex,
        vsync: this,
      )..addListener(_handleTabChange);
    } else {
      widget.controller!.addListener(_handleTabChange);
    }
  }

  @override
  void didUpdateWidget(covariant SilkTabNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?.removeListener(_handleTabChange);
      widget.controller?.addListener(_handleTabChange);
      if (widget.controller != null && _internalController != null) {
        _internalController!.removeListener(_handleTabChange);
        _internalController!.dispose();
        _internalController = null;
      } else if (widget.controller == null && _internalController == null) {
        _internalController = TabController(
          length: widget.items.length,
          initialIndex: widget.initialIndex,
          vsync: this,
        )..addListener(_handleTabChange);
      }
    }
  }

  void _handleTabChange() {
    if (!_controller.indexIsChanging) {
      widget.onChanged?.call(_controller.index);
    }
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTabChange);
    _internalController?.removeListener(_handleTabChange);
    _internalController?.dispose();
    super.dispose();
  }

  Widget _buildPageContainer() {
    final bottomPadding =
        NavigationGap.bottomMargin +
        NavigationGap.containerPadding * 2 +
        NavigationGap.tabHeight +
        NavigationGap.fontSize +
        2;
    final padded = widget.pages
        .map(
          (p) => Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: p,
          ),
        )
        .toList();

    if (widget.keepPagesMounted) {
      return IndexedStack(index: _controller.index, children: padded);
    }
    return padded[_controller.index];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);

    return Scaffold(
      backgroundColor: scheme.background,
      body: _buildPageContainer(),
      extendBody: true,
      bottomNavigationBar: _FloatingNav(
        controller: _controller,
        items: widget.items,
        scheme: scheme,
      ),
    );
  }
}

class _FloatingNav extends StatelessWidget {
  final TabController controller;
  final List<SilkTabNavigationItem> items;
  final SilkColorScheme scheme;

  const _FloatingNav({
    required this.controller,
    required this.items,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          NavigationGap.sideMargin,
          0,
          NavigationGap.sideMargin,
          NavigationGap.bottomMargin,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(NavigationGap.containerRadius),
            boxShadow: ShadowConfig.lg.boxShadows,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(NavigationGap.containerRadius),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
              child: Container(
                decoration: BoxDecoration(
                  color: scheme.card.withValues(alpha: 0.72),
                  border: Border.all(
                    color: scheme.border.withValues(alpha: 0.5),
                    width: SilkBorder.width,
                  ),
                ),
                padding: const EdgeInsets.all(NavigationGap.containerPadding),
                child: Row(
                  children: List.generate(items.length, (i) {
                    final selected = controller.index == i;
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.animateTo(i);
                        },
                        behavior: HitTestBehavior.opaque,
                        child: _NavItem(
                          item: items[i],
                          selected: selected,
                          scheme: scheme,
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final SilkTabNavigationItem item;
  final bool selected;
  final SilkColorScheme scheme;

  const _NavItem({
    required this.item,
    required this.selected,
    required this.scheme,
  });

  @override
  Widget build(BuildContext context) {
    final activeColor = scheme.foreground;
    final inactiveColor = scheme.mutedForeground;

    return AnimatedContainer(
      duration: SilkAnimation.duration,
      curve: SilkAnimation.spring,
      height: NavigationGap.tabHeight,
      decoration: BoxDecoration(
        color: selected ? scheme.muted : Colors.transparent,
        borderRadius: BorderRadius.circular(NavigationGap.itemRadius),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedSwitcher(
            duration: SilkAnimation.duration,
            transitionBuilder: (child, anim) {
              return ScaleTransition(
                scale: Tween(begin: 0.6, end: 1.0).animate(
                  CurvedAnimation(parent: anim, curve: SilkAnimation.overshoot),
                ),
                child: FadeTransition(opacity: anim, child: child),
              );
            },
            child: Icon(
              selected ? (item.selectedIcon ?? item.icon) : item.icon,
              key: ValueKey('${item.label}_$selected'),
              color: selected ? activeColor : inactiveColor,
              size: NavigationGap.iconSize,
            ),
          ),
          const SizedBox(height: 2),
          AnimatedDefaultTextStyle(
            duration: SilkAnimation.duration,
            style: TextStyle(
              color: selected ? activeColor : inactiveColor,
              fontSize: NavigationGap.fontSize,
              fontWeight: selected
                  ? SilkTypography.semibold
                  : SilkTypography.medium,
              letterSpacing: SilkTypography.trackingWide,
              fontFamily: '.SF Pro Text',
            ),
            child: Text(item.label ?? ''),
          ),
        ],
      ),
    );
  }
}
