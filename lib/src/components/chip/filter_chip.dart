import 'package:flutter/material.dart';

import '../../theme/colors.dart';
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
              color: isSelected ? SilkColors.dark : Colors.transparent,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected ? SilkColors.light : SilkColors.dark,
                fontSize: SilkTypography.md,
                fontFamily: SilkTypography.fontFamily,
              ),
            ),
          ),
        );
      }).toList(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: SilkColors.muted,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: SilkColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$label ',
              style: const TextStyle(
                color: SilkColors.mutedForeground,
                fontSize: SilkTypography.sm,
                fontWeight: FontWeight.w400,
                fontFamily: SilkTypography.fontFamily,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: SilkColors.dark,
                fontSize: SilkTypography.sm,
                fontWeight: FontWeight.w600,
                fontFamily: SilkTypography.fontFamily,
              ),
            ),
            const SizedBox(width: 2),
            const Icon(
              Icons.keyboard_arrow_down,
              size: 14,
              color: SilkColors.mutedForeground,
            ),
          ],
        ),
      ),
    );
  }
}
