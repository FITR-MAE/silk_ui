import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/typography.dart';

class SilkToggleChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const SilkToggleChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? SilkColors.dark : SilkColors.muted,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? SilkColors.dark : SilkColors.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? SilkColors.light : SilkColors.dark,
            fontSize: SilkTypography.sm,
            fontWeight: FontWeight.w600,
            fontFamily: SilkTypography.fontFamily,
          ),
        ),
      ),
    );
  }
}
