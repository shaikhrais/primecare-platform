import 'package:flutter_core/00_B_flutter_core.dart';
import 'package:primecare_ui/src/theme/01_I_primecare_theme.dart';
import 'package:primecare_ui/src/components/01_I_primecare_card.dart';

class IntelligenceInsightCard extends StatelessWidget {
  final IntelligenceInsight insight;

  const IntelligenceInsightCard({super.key, required this.insight});

  @override
  Widget build(BuildContext context) {
    final theme = PrimeCareTheme.of(context);

    final impactColor = switch (insight.impact) {
      InsightImpact.positive => Colors.green,
      InsightImpact.caution => Colors.orange,
      InsightImpact.alert => theme.colors.error,
      InsightImpact.info ||
      InsightImpact.standard ||
      InsightImpact.success ||
      InsightImpact.high ||
      InsightImpact.low ||
      InsightImpact.medium => theme.colors.primary,
      InsightImpact.growth => Colors.blue,
      InsightImpact.warning => Colors.orange,
      InsightImpact.critical => theme.colors.error,
    };

    final icon = switch (insight.type) {
      InsightType.alert => LucideIcons.activity,
      InsightType.growth => LucideIcons.trendingUp,
      InsightType.optimization => LucideIcons.zap,
      InsightType.compliance => LucideIcons.shieldCheck,
      InsightType.risk => LucideIcons.shieldAlert,
      _ => LucideIcons.pieChart,
    };

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: impactColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: impactColor, size: 18),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      insight.title,
                      style: theme.typography.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      insight.category ?? 'Strategic Intelligence',
                      style: theme.typography.labelSmall.copyWith(
                        color: theme.colors.slateGray,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(insight.summary, style: theme.typography.bodySmall),
          if (insight.recommendation != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colors.primary.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    LucideIcons.lightbulb,
                    color: theme.colors.primary,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      insight.recommendation!,
                      style: theme.typography.bodySmall.copyWith(
                        color: theme.colors.primary,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
