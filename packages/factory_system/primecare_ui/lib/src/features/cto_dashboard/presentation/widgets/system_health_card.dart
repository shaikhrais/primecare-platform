// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

class SystemHealthCard extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final IconData icon;
  final Color? color;

  const SystemHealthCard({
    super.key,
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final effectiveColor = color ?? theme.colors.primary;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      // Tonal Layering: No borders, just surface shift
      backgroundColor: theme.colors.surfaceContainerHigh.withValues(alpha: 0.8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(theme.spacing.xs),
                decoration: BoxDecoration(
                  color: effectiveColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: effectiveColor, size: 18),
              ),
              SizedBox(width: theme.spacing.sm),
              Text(
                label.toUpperCase(),
                style: theme.typography.labelSmall.copyWith(
                  letterSpacing: 1.0,
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value.toStringAsFixed(0),
                style: theme.typography.h1.copyWith(
                  fontWeight: FontWeight.w900,
                  fontSize: 32,
                ),
              ),
              SizedBox(width: 4),
              Text(
                unit,
                style: theme.typography.label.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.sm),
          LinearProgressIndicator(
            value: value / 100,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: effectiveColor,
            minHeight: 4,
            borderRadius: BorderRadius.circular(2),
          ),
        ],
      ),
    );
  }
}
