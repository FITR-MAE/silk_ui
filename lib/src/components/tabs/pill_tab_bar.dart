import 'package:flutter/material.dart';

import '../../theme/colors.dart';
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

  Color get _containerColor {
    switch (style) {
      case PillTabStyle.light:
        return Colors.white.withValues(alpha: 0.1);
      case PillTabStyle.dark:
        return SilkColors.muted;
      case PillTabStyle.outlined:
        return SilkColors.light;
    }
  }

  Border? get _containerBorder {
    switch (style) {
      case PillTabStyle.light:
        return Border.all(color: Colors.white.withValues(alpha: 0.1));
      case PillTabStyle.dark:
        return null;
      case PillTabStyle.outlined:
        return Border.all(color: SilkColors.border);
    }
  }

  Color get _selectedPillColor {
    switch (style) {
      case PillTabStyle.light:
        return SilkColors.light;
      case PillTabStyle.dark:
      case PillTabStyle.outlined:
        return SilkColors.dark;
    }
  }

  Color get _selectedTextColor {
    switch (style) {
      case PillTabStyle.light:
        return SilkColors.dark;
      case PillTabStyle.dark:
      case PillTabStyle.outlined:
        return SilkColors.light;
    }
  }

  Color get _unselectedTextColor {
    switch (style) {
      case PillTabStyle.light:
        return Colors.white.withValues(alpha: 0.75);
      case PillTabStyle.dark:
      case PillTabStyle.outlined:
        return SilkColors.mutedForeground;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: _containerColor,
        borderRadius: BorderRadius.circular(24),
        border: _containerBorder,
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
                color: isSelected ? _selectedPillColor : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                tabs[i],
                style: TextStyle(
                  color: isSelected ? _selectedTextColor : _unselectedTextColor,
                  fontSize: SilkTypography.sm,
                  fontWeight: FontWeight.w500,
                  fontFamily: SilkTypography.fontFamily,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
