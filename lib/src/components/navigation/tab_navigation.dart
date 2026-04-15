import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import 'gap.dart';

class SilkTabNavigationItem {
  final String label;
  final IconData? icon;

  const SilkTabNavigationItem({required this.label, this.icon});
}

class SilkTabNavigation extends StatelessWidget {
  final List<SilkTabNavigationItem> items;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final Widget child;

  const SilkTabNavigation({
    super.key,
    required this.items,
    required this.child,
    this.initialIndex = 0,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? SilkColors.dark : SilkColors.light;
    final fg = isDark ? SilkColors.light : SilkColors.dark;

    return DefaultTabController(
      length: items.length,
      initialIndex: initialIndex,
      child: Builder(
        builder: (context) {
          final controller = DefaultTabController.of(context);
          controller.addListener(() {
            if (!controller.indexIsChanging) onChanged?.call(controller.index);
          });
          return Column(
            children: [
              Expanded(child: child),
              Container(height: SilkBorder.width, color: fg),
              SafeArea(
                top: false,
                child: Container(
                  color: bg,
                  padding: const EdgeInsets.all(NavigationGap.containerPadding),
                  child: TabBar(
                    isScrollable: false,
                    labelColor: bg,
                    unselectedLabelColor: fg,
                    indicatorSize: TabBarIndicatorSize.tab,
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
                      for (final item in items)
                        Tab(
                          icon: item.icon != null ? Icon(item.icon) : null,
                          text: item.label,
                          iconMargin: const EdgeInsets.only(bottom: 2),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
