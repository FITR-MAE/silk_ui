import 'package:flutter/material.dart';

import '../../theme/border.dart';
import '../../theme/color_scheme.dart';
import '../../theme/spacing.dart';
import '../../theme/typography.dart';

enum SilkTabStyle { pill, button, outline }

enum SilkTabsVariant { list, overlay }

class SilkTabItem {
  final String label;
  final Widget child;

  const SilkTabItem({required this.label, required this.child});
}

class SilkTabs extends StatefulWidget {
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
    this.padding = SilkSpacing.s2,
    this.variant = SilkTabsVariant.list,
  });

  @override
  State<SilkTabs> createState() => _SilkTabsState();
}

class _SilkTabsState extends State<SilkTabs>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  late int _reportedIndex;

  @override
  void initState() {
    super.initState();
    assert(widget.items.isNotEmpty);
    assert(
      widget.initialIndex >= 0 && widget.initialIndex < widget.items.length,
    );
    _reportedIndex = widget.initialIndex;
    _controller = _createController(widget.items.length, widget.initialIndex);
  }

  @override
  void didUpdateWidget(covariant SilkTabs oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.items.length != widget.items.length) {
      final index = _controller.index.clamp(0, widget.items.length - 1);
      _controller.removeListener(_handleTabChange);
      _controller.dispose();
      _reportedIndex = index;
      _controller = _createController(widget.items.length, index);
    }
  }

  TabController _createController(int length, int initialIndex) {
    return TabController(
      length: length,
      initialIndex: initialIndex,
      vsync: this,
    )..addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (_controller.indexIsChanging || _controller.index == _reportedIndex) {
      return;
    }
    _reportedIndex = _controller.index;
    widget.onChanged?.call(_reportedIndex);
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    _controller.dispose();
    super.dispose();
  }

  double _radius() {
    switch (widget.style) {
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
    switch (widget.style) {
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
    final scheme = SilkColorScheme.of(context);
    final filled = widget.style != SilkTabStyle.outline;
    final tabBar = Padding(
      padding: EdgeInsets.all(widget.padding),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(SilkSpacing.s1),
          decoration: BoxDecoration(
            color: scheme.muted,
            borderRadius: BorderRadius.circular(_radius()),
            border: Border.all(
              color: scheme.border,
              width: SilkBorder.width,
              style: SilkBorder.style,
            ),
          ),
          child: IntrinsicWidth(
            child: TabBar(
              controller: _controller,
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              labelColor: filled ? scheme.background : scheme.foreground,
              unselectedLabelColor: scheme.mutedForeground,
              indicator: _indicator(scheme.foreground),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: Colors.transparent,
              splashBorderRadius: BorderRadius.circular(_radius()),
              labelPadding: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              labelStyle: const TextStyle(
                fontSize: SilkTypography.sm,
                fontWeight: SilkTypography.semibold,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: SilkTypography.sm,
                fontWeight: SilkTypography.normal,
              ),
              tabs: [
                for (final item in widget.items)
                  Tab(
                    height: SilkSpacing.s10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: SilkSpacing.s3,
                      ),
                      child: Text(
                        item.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    final tabBarView = TabBarView(
      controller: _controller,
      children: [for (final item in widget.items) item.child],
    );

    if (widget.variant == SilkTabsVariant.overlay) {
      return Stack(
        children: [
          Positioned.fill(child: tabBarView),
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: SafeArea(bottom: false, child: tabBar),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        tabBar,
        Expanded(child: tabBarView),
      ],
    );
  }
}
