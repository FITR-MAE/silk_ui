import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

enum SilkTabStyle { pill, button, outline }

enum SilkTabsVariant { list, overlay }

class SilkTabItem {
  final String label;
  final Widget child;

  const SilkTabItem({required this.label, required this.child});
}

class SilkTabs extends StatelessWidget {
  final List<SilkTabItem> items;
  final int initialIndex;
  final ValueChanged<int>? onChanged;
  final SilkTabStyle style;
  final double padding;
  final SilkTabsVariant variant;

  const SilkTabs({
    super.key,
    required this.items,
    this.initialIndex = 0,
    this.onChanged,
    this.style = SilkTabStyle.pill,
    this.padding = SilkSpacing.xs,
    this.variant = SilkTabsVariant.list,
  });

  double _radius() {
    switch (style) {
      case SilkTabStyle.pill:
        return SilkBorder.radiusRound;
      case SilkTabStyle.button:
        return SilkBorder.radiusMd;
      case SilkTabStyle.outline:
        return SilkBorder.radiusSm;
    }
  }

  Decoration _indicator(Color fg) {
    final radius = BorderRadius.circular(_radius());
    switch (style) {
      case SilkTabStyle.pill:
      case SilkTabStyle.button:
        return BoxDecoration(color: fg, borderRadius: radius);
      case SilkTabStyle.outline:
        return BoxDecoration(
          borderRadius: radius,
          border: Border.all(
            color: fg,
            width: SilkBorder.width * 2,
            style: SilkBorder.style,
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final fg = isDark ? SilkColors.light : SilkColors.dark;
    final bg = isDark ? SilkColors.dark : SilkColors.light;
    final filled = style != SilkTabStyle.outline;

    return DefaultTabController(
      length: items.length,
      initialIndex: initialIndex,
      child: Builder(
        builder: (context) {
          final controller = DefaultTabController.of(context);
          controller.addListener(() {
            if (!controller.indexIsChanging) onChanged?.call(controller.index);
          });
          final tabBar = Padding(
            padding: EdgeInsets.all(SilkSpacing.lg),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                padding: EdgeInsets.all(SilkSpacing.md),
                decoration: BoxDecoration(
                  color: SilkColors.grey.withAlpha(16),
                  borderRadius: BorderRadius.circular(_radius()),
                  border: Border.all(
                    color: fg.withAlpha(64),
                    width: SilkBorder.width,
                    style: SilkBorder.style,
                  ),
                ),
                child: IntrinsicWidth(
                  child: TabBar(
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    labelColor: filled ? bg : fg,
                    unselectedLabelColor: fg,
                    indicator: _indicator(fg),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    splashBorderRadius: BorderRadius.circular(_radius()),
                    labelPadding: const EdgeInsets.all(SilkSpacing.none),
                    padding: const EdgeInsets.all(SilkSpacing.none),
                    labelStyle: const TextStyle(
                      fontSize: SilkTypography.sm,
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: const TextStyle(
                      fontSize: SilkTypography.sm,
                      fontWeight: FontWeight.w400,
                    ),
                    tabs: [
                      for (final item in items)
                        Tab(
                          height: SilkSpacing.iconButtonSideXs,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: SilkSpacing.lg,
                            ),
                            child: Text(item.label),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          );

          final tabBarView = TabBarView(
            children: [for (final item in items) item.child],
          );

          if (variant == SilkTabsVariant.overlay) {
            return Stack(
              children: [
                Positioned.fill(child: tabBarView),
                Positioned(left: 0, right: 0, top: 0, child: tabBar),
              ],
            );
          }

          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              tabBar,
              Expanded(child: tabBarView),
            ],
          );
        },
      ),
    );
  }
}
