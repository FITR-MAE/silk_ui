import 'package:flutter/material.dart';

import '../../theme/color_scheme.dart';
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
    final scheme = SilkColorScheme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: isSelected ? scheme.primary : scheme.muted,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? scheme.primary : scheme.border,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? scheme.primaryForeground : scheme.foreground,
            fontSize: SilkTypography.sm,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
