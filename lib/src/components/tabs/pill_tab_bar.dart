import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';
import '../../theme/typography.dart';

enum PillTabStyle { light, dark, outlined }

class SilkPillTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;
  final PillTabStyle style;

  const SilkPillTabBar({
    super.key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabChanged,
    this.style = PillTabStyle.dark,
  });

  Color _containerColor(SilkColorScheme scheme) {
    switch (style) {
      case PillTabStyle.light:
        return Colors.white.withValues(alpha: 0.1);
      case PillTabStyle.dark:
        return scheme.muted;
      case PillTabStyle.outlined:
        return scheme.background;
    }
  }

  Border? _containerBorder(SilkColorScheme scheme) {
    switch (style) {
      case PillTabStyle.light:
        return Border.all(color: Colors.white.withValues(alpha: 0.1));
      case PillTabStyle.dark:
        return null;
      case PillTabStyle.outlined:
        return Border.all(color: scheme.border);
    }
  }

  Color _selectedPillColor(SilkColorScheme scheme) {
    switch (style) {
      case PillTabStyle.light:
        return scheme.background;
      case PillTabStyle.dark:
      case PillTabStyle.outlined:
        return scheme.primary;
    }
  }

  Color _selectedTextColor(SilkColorScheme scheme) {
    switch (style) {
      case PillTabStyle.light:
        return scheme.foreground;
      case PillTabStyle.dark:
      case PillTabStyle.outlined:
        return scheme.primaryForeground;
    }
  }

  Color _unselectedTextColor(SilkColorScheme scheme) {
    switch (style) {
      case PillTabStyle.light:
        return Colors.white.withValues(alpha: 0.75);
      case PillTabStyle.dark:
      case PillTabStyle.outlined:
        return scheme.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);

    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _containerColor(scheme),
        borderRadius: BorderRadius.circular(24),
        border: _containerBorder(scheme),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(tabs.length, (i) {
          final isSelected = selectedIndex == i;
          return GestureDetector(
            onTap: () => onTabChanged(i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
              decoration: BoxDecoration(
                color: isSelected
                    ? _selectedPillColor(scheme)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  color: isSelected
                      ? _selectedTextColor(scheme)
                      : _unselectedTextColor(scheme),
                  fontSize: SilkTypography.sm,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
