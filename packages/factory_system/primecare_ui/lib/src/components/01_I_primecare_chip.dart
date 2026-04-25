// Layer: 01_INFRASTRUCTURE

import 'package:primecare_ui/primecare_ui.dart';

/// A high-fidelity actionable chip used in command hubs and action rows.
class PrimeCareChip extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback? onPressed;
  final Color? color;

  const PrimeCareChip({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final chipColor = color ?? theme.colors.surfaceContainerHigh;
    final textColor = color != null
        ? PrimeCareColors.white
        : theme.colors.onSurface;

    return ActionChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: textColor),
            SizedBox(width: theme.spacing.sm),
          ],
          Text(
            label,
            style: theme.typography.labelMedium.copyWith(color: textColor),
          ),
        ],
      ),
      backgroundColor: chipColor,
      onPressed: onPressed,
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacing.md,
        vertical: theme.spacing.sm,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.spacing.sm),
        side: BorderSide(
          color: color?.withValues(alpha: 0.5) ?? theme.colors.borderLight,
        ),
      ),
    );
  }
}
