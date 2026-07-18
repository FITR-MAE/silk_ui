import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';
import '../../theme/typography.dart';

class SilkFilterChip extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const SilkFilterChip({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = SilkColorScheme.of(context);

    return PopupMenuButton<String>(
      onSelected: onChanged,
      offset: const Offset(0, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      itemBuilder: (context) => options.map((option) {
        final isSelected = option == value;
        return PopupMenuItem<String>(
          height: 36,
          value: option,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected ? scheme.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? scheme.primaryForeground
                    : scheme.foreground,
                fontSize: SilkTypography.md,
              ),
            ),
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: scheme.muted,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: scheme.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label ',
              style: TextStyle(
                color: scheme.mutedForeground,
                fontSize: SilkTypography.sm,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: scheme.foreground,
                fontSize: SilkTypography.sm,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: scheme.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}
