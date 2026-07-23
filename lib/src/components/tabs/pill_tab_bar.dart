import 'dart:math' as math;

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
        return Colors.white;
      case PillTabStyle.dark:
      case PillTabStyle.outlined:
        return scheme.primary;
    }
  }

  Color _selectedTextColor(SilkColorScheme scheme) {
    switch (style) {
      case PillTabStyle.light:
        return Colors.black;
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
    final textDirection = Directionality.of(context);
    final textScaler = MediaQuery.textScalerOf(context);
    const textStyle = TextStyle(
      fontSize: 11,
      fontWeight: SilkTypography.medium,
    );
    final textPainters = tabs.map((tab) {
      return TextPainter(
        text: TextSpan(text: tab, style: textStyle),
        textDirection: textDirection,
        textScaler: textScaler,
        maxLines: 1,
      )..layout();
    }).toList();
    final tabWidths = textPainters
        .map((painter) => math.max(44.0, painter.width + 20))
        .toList();
    final targetHeight = math.max(
      44.0,
      textPainters.fold(0.0, (height, painter) {
            return math.max(height, painter.height);
          }) +
          12,
    );
    final totalWidth = tabWidths.fold(6.0, (width, tabWidth) {
      return width + tabWidth;
    });

    return SizedBox(
      width: totalWidth,
      height: targetHeight,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ExcludeSemantics(
            child: IgnorePointer(
              child: Align(
                widthFactor: 1,
                heightFactor: 1,
                child: Container(
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
                      return Container(
                        width: tabWidths[i],
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? _selectedPillColor(scheme)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Align(
                          heightFactor: 1,
                          child: Text(
                            tabs[i],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: textStyle.copyWith(
                              color: isSelected
                                  ? _selectedTextColor(scheme)
                                  : _unselectedTextColor(scheme),
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
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Row(
                children: List.generate(tabs.length, (i) {
                  final isSelected = selectedIndex == i;
                  final radius = BorderRadius.circular(20);
                  return Semantics(
                    button: true,
                    enabled: true,
                    selected: isSelected,
                    label: tabs[i],
                    onTap: () => onTabChanged(i),
                    excludeSemantics: true,
                    child: SizedBox(
                      width: tabWidths[i],
                      height: targetHeight,
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: radius,
                        child: InkWell(
                          onTap: () => onTabChanged(i),
                          borderRadius: radius,
                          hoverColor: scheme.hoverOverlay,
                          focusColor: scheme.focusOverlay,
                          excludeFromSemantics: true,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
