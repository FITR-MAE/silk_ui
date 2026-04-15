import 'package:flutter/material.dart';

import '../../theme/animation.dart';
import '../../theme/colors.dart';
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

  const SilkTabNavigation({
    super.key,
    required this.items,
    required this.pages,
    this.initialIndex = 0,
    this.onChanged,
    this.keepPagesMounted = false,
  }) : assert(items.length == pages.length);

  @override
  State<SilkTabNavigation> createState() => _SilkTabNavigationState();
}

class _SilkTabNavigationState extends State<SilkTabNavigation>
    with SingleTickerProviderStateMixin {
  late final TabController _controller = TabController(
    length: widget.items.length,
    initialIndex: widget.initialIndex,
    vsync: this,
    animationDuration: SilkAnimation.duration,
  )..addListener(_handleTabChange);

  void _handleTabChange() {
    if (!_controller.indexIsChanging) {
      widget.onChanged?.call(_controller.index);
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPageContainer() {
    if (widget.keepPagesMounted) {
      return IndexedStack(index: _controller.index, children: widget.pages);
    }

    return widget.pages[_controller.index];
  }

  Widget _buildIcon(
    SilkTabNavigationItem item,
    bool isSelected,
    Color selectedColor,
    Color unselectedColor,
  ) {
    if (item.icon == null) return const SizedBox.shrink();

    final icon = isSelected ? (item.selectedIcon ?? item.icon) : item.icon;
    return Icon(icon, color: isSelected ? selectedColor : unselectedColor);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? SilkColors.dark : SilkColors.light;
    final fg = isDark ? SilkColors.light : SilkColors.dark;

    return Column(
      children: [
        Expanded(child: _buildPageContainer()),
        SafeArea(
          top: false,
          child: Container(
            color: bg,
            padding: const EdgeInsets.all(NavigationGap.containerPadding),
            child: TabBar(
              controller: _controller,
              isScrollable: false,
              labelColor: bg,
              unselectedLabelColor: fg,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorAnimation: TabIndicatorAnimation.elastic,
              splashBorderRadius: BorderRadius.circular(NavigationGap.itemRadius),
              indicator: BoxDecoration(
                color: fg,
                borderRadius: BorderRadius.circular(NavigationGap.itemRadius),
              ),
              dividerColor: Colors.transparent,
              labelStyle: const TextStyle(
                fontSize: NavigationGap.fontSize,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: NavigationGap.fontSize,
                fontWeight: FontWeight.w400,
              ),
              tabs: [
                for (var i = 0; i < widget.items.length; i++)
                  Tab(
                    icon: _buildIcon(
                      widget.items[i],
                      _controller.index == i,
                      bg,
                      fg,
                    ),
                    text: widget.items[i].label,
                    iconMargin: const EdgeInsets.only(bottom: 2),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
