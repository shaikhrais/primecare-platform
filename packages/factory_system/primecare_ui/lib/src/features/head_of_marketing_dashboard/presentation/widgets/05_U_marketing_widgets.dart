// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

/// A heatmap showing performance across active marketing campaigns.
class CampaignPerformanceHeatmap extends StatelessWidget {
  final AnalyticsChart chart;

  const CampaignPerformanceHeatmap({super.key, required this.chart});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Campaign ROI Matrix', style: theme.typography.h3),
                  Text(
                    'Real-time conversion efficiency by channel',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              PrimeCareStatusBadge(label: 'ROAS 4.2x', type: BadgeType.success),
            ],
          ),
          SizedBox(height: theme.spacing.lg),
          SizedBox(height: 250, child: PrimeCareBarChart(chart: chart)),
        ],
      ),
    );
  }
}

/// A standardized lead acquisition funnel.
class LeadAcquisitionFunnel extends StatelessWidget {
  const LeadAcquisitionFunnel({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Lead Conversion Funnel', style: theme.typography.h3),
          Text(
            'End-to-end acquisition velocity tracking',
            style: theme.typography.labelMedium,
          ),
          SizedBox(height: theme.spacing.lg),
          _buildFunnelRow(
            theme,
            'AWARENESS',
            '1.2k',
            1.0,
            theme.colors.primary,
          ),
          _buildFunnelRow(theme, 'INTEREST', '840', 0.7, theme.colors.info),
          _buildFunnelRow(
            theme,
            'CONSIDERATION',
            '320',
            0.4,
            theme.colors.warning,
          ),
          _buildFunnelRow(
            theme,
            'CONVERSION',
            '156',
            0.2,
            theme.colors.success,
          ),
        ],
      ),
    );
  }

  Widget _buildFunnelRow(
    PrimeCareThemeData theme,
    String label,
    String value,
    double widthFactor,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: theme.typography.labelSmall),
              Text(
                value,
                style: theme.typography.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          FractionallySizedBox(
            widthFactor: widthFactor,
            child: Container(
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Marketing action hub for the Head of Marketing.
class MarketingActionHub extends StatelessWidget {
  MarketingActionHub({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareQuickActionsGrid(
      actions: [
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_new_campaign.tr(),
          icon: LucideIcons.plusCircle,
          route: '/marketing/campaigns/new',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_brand_assets.tr(),
          icon: LucideIcons.image,
          route: '/marketing/assets',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_analytics.tr(),
          icon: LucideIcons.pieChart,
          route: '/marketing/analytics',
        ),
        PrimeCareActionItem(
          title: LocaleKeys.dashboards_common_labels_lead_gen.tr(),
          icon: LucideIcons.userPlus,
          route: '/marketing/leads',
        ),
      ],
    );
  }
}
