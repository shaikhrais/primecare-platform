// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/primecare_ui.dart';

class CtoBriefingPanel extends StatelessWidget {
  final List<IntelligenceInsight> insights;

  const CtoBriefingPanel({super.key, required this.insights});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      // Glassmorphic Obsidian Aesthetic
      backgroundColor: theme.colors.surfaceContainerLow.withValues(alpha: 0.6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.sparkles, color: theme.colors.primary, size: 20),
              SizedBox(width: theme.spacing.sm),
              Text(
                'EXECUTIVE BRIEFING • AURA AI',
                style: theme.typography.label.copyWith(
                  letterSpacing: 2.0,
                  color: theme.colors.primary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          if (insights.isEmpty)
            Text(
              'No critical anomalies detected. System integrity is at 100%. All primary regional nodes are performing within expected latency parameters.',
              style: theme.typography.bodyLarge.copyWith(
                color: theme.colors.onSurfaceVariant,
                height: 1.6,
              ),
            )
          else
            ...insights.map((insight) => _buildInsightItem(theme, insight)),
        ],
      ),
    );
  }

  Widget _buildInsightItem(
    PrimeCareThemeData theme,
    IntelligenceInsight insight,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: theme.spacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 6),
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: _getImpactColor(theme, insight.impact),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  insight.title,
                  style: theme.typography.bodyLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  insight.summary,
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getImpactColor(PrimeCareThemeData theme, InsightImpact impact) {
    switch (impact) {
      case InsightImpact.alert:
        return theme.colors.error;
      case InsightImpact.caution:
        return theme.colors.warning;
      case InsightImpact.positive:
        return theme.colors.success;
      case InsightImpact.info:
      case InsightImpact.standard:
      case InsightImpact.success:
      case InsightImpact.high:
      case InsightImpact.low:
      case InsightImpact.medium:
        return theme.colors.info;
      case InsightImpact.growth:
        return theme.colors.success;
      case InsightImpact.warning:
        return theme.colors.warning;
      case InsightImpact.critical:
        return theme.colors.error;
    }
  }
}
