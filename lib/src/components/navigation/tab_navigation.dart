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
  final bool hideBottomBar;
  final SilkShadow shadow;

  /// Optional external controller. If provided, the caller owns the controller
  /// and is responsible for disposing it. [initialIndex] is ignored.
  final TabController? controller;

  const SilkTabNavigation({
    super.key,
    required this.items,
    required this.pages,
    this.initialIndex = 0,
    this.onChanged,
    this.keepPagesMounted = false,
    this.hideBottomBar = false,
    this.shadow = SilkShadow.none,
    this.controller,
  });

  @override
  State<SilkTabNavigation> createState() => _SilkTabNavigationState();
}

class _SilkTabNavigationState extends State<SilkTabNavigation>
    with TickerProviderStateMixin {
  TabController? _internalController;
  late int _currentIndex;
  late int _reportedIndex;

  TabController get _controller => widget.controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    _assertConfiguration();
    if (widget.controller == null) {
      _internalController = TabController(
        length: widget.items.length,
        initialIndex: widget.initialIndex,
        vsync: this,
      );
    }
    _currentIndex = _controller.index;
    _reportedIndex = _currentIndex;
    _controller.addListener(_handleTabChange);
  }

  @override
  void didUpdateWidget(covariant SilkTabNavigation oldWidget) {
    super.didUpdateWidget(oldWidget);
    _assertConfiguration();

    if (oldWidget.controller != widget.controller) {
      final previousController = oldWidget.controller ?? _internalController!;
      final previousIndex = previousController.index;
      previousController.removeListener(_handleTabChange);

      if (oldWidget.controller == null) {
        _internalController!.dispose();
        _internalController = null;
      }

      if (widget.controller == null) {
        _internalController = TabController(
          length: widget.items.length,
          initialIndex: previousIndex.clamp(0, widget.items.length - 1),
          vsync: this,
        );
      }

      _currentIndex = _controller.index;
      _reportedIndex = _currentIndex;
      _controller.addListener(_handleTabChange);
    } else if (widget.controller == null &&
        oldWidget.items.length != widget.items.length) {
      final index = _internalController!.index.clamp(
        0,
        widget.items.length - 1,
      );
      _internalController!.removeListener(_handleTabChange);
      _internalController!.dispose();
      _internalController = TabController(
        length: widget.items.length,
        initialIndex: index,
        vsync: this,
      )..addListener(_handleTabChange);
      _currentIndex = index;
      _reportedIndex = index;
    }
  }

  void _assertConfiguration() {
    assert(widget.items.isNotEmpty);
    assert(widget.items.length == widget.pages.length);
    assert(
      widget.initialIndex >= 0 && widget.initialIndex < widget.items.length,
    );
    assert(
      widget.controller == null ||
          widget.controller!.length == widget.items.length,
      'The TabController length must match the number of navigation items.',
    );
  }

  void _handleTabChange() {
    final index = _controller.index;
    if (index != _currentIndex) {
      _currentIndex = index;
      if (mounted) setState(() {});
    }
    if (!_controller.indexIsChanging && index != _reportedIndex) {
      _reportedIndex = index;
      widget.onChanged?.call(index);
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleTabChange);
    _internalController?.removeListener(_handleTabChange);
    _internalController?.dispose();
    super.dispose();
  }

  Widget _buildPageContainer(BuildContext context) {
    final bottomPadding = widget.hideBottomBar
        ? 0.0
        : MediaQuery.viewPaddingOf(context).bottom +
              NavigationGap.bottomMargin +
              NavigationGap.containerPadding * 2 +
              NavigationGap.tabHeight;
    final padded = widget.pages
        .map(
          (p) => Padding(
            padding: EdgeInsets.only(bottom: bottomPadding),
            child: p,
          ),
        )
        .toList();

    if (widget.keepPagesMounted) {
      return IndexedStack(index: _currentIndex, children: padded);
    }
    return padded[_currentIndex];
  }

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);

    return Scaffold(
      backgroundColor: scheme.background,
      body: _buildPageContainer(context),
      extendBody: true,
      bottomNavigationBar: widget.hideBottomBar
          ? null
          : _FloatingNav(
              controller: _controller,
              items: widget.items,
              scheme: scheme,
              shadow: widget.shadow,
            ),
    );
  }
}

class _FloatingNav extends StatelessWidget {
  final TabController controller;
  final List<SilkTabNavigationItem> items;
  final SilkColorScheme scheme;
  final SilkShadow shadow;

  const _FloatingNav({
    required this.controller,
    required this.items,
    required this.scheme,
    required this.shadow,
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
            boxShadow: shadow.config.boxShadows,
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
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    children: List.generate(items.length, (i) {
                      final selected = controller.index == i;
                      final item = items[i];
                      return Expanded(
                        child: Semantics(
                          button: true,
                          enabled: true,
                          selected: selected,
                          label: item.label ?? 'Tab ${i + 1}',
                          onTap: () => controller.animateTo(i),
                          excludeSemantics: true,
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              minWidth: 44,
                              minHeight: 44,
                            ),
                            child: InkWell(
                              onTap: () => controller.animateTo(i),
                              borderRadius: BorderRadius.circular(
                                NavigationGap.itemRadius,
                              ),
                              hoverColor: scheme.hoverOverlay,
                              focusColor: scheme.focusOverlay,
                              excludeFromSemantics: true,
                              child: _NavItem(
                                item: item,
                                selected: selected,
                                scheme: scheme,
                              ),
                            ),
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
          if (item.icon != null) ...[
            AnimatedSwitcher(
              duration: SilkAnimation.duration,
              transitionBuilder: (child, anim) {
                return ScaleTransition(
                  scale: Tween(begin: 0.6, end: 1.0).animate(
                    CurvedAnimation(
                      parent: anim,
                      curve: SilkAnimation.overshoot,
                    ),
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
            if (item.label != null) const SizedBox(height: 2),
          ],
          AnimatedDefaultTextStyle(
            duration: SilkAnimation.duration,
            style: TextStyle(
              color: selected ? activeColor : inactiveColor,
              fontSize: NavigationGap.fontSize,
              fontWeight: selected
                  ? SilkTypography.semibold
                  : SilkTypography.medium,
              letterSpacing: SilkTypography.trackingWide,
            ),
            child: Text(
              item.label ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
