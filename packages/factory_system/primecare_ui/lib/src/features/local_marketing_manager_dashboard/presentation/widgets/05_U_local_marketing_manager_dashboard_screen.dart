// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class LocalMarketingManagerDashboardScreen extends ConsumerWidget {
  const LocalMarketingManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(localMarketingManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () =>
            ref.refresh(localMarketingManagerDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    LocalMarketingManagerDashboardViewModel viewModel,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(LocaleKeys.command_center_labels_marketing_center.tr(), style: theme.typography.h2),
                  Text(
                    'Growth telemetry, campaign ROI, and lead conversion velocity',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildCampaignPerformance(context, theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildLeadConversionFunnel(context, theme),
                  ],
                ),
              ),
              if (viewModel.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(
                  child: _buildAuraInsightsColumn(theme, viewModel.insights),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCampaignPerformance(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Active Campaign ROI', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildPerformanceRow(
            theme,
            'Senior Living Expo',
            0.85,
            theme.colors.success,
          ),
          _buildPerformanceRow(
            theme,
            'Facebook Outreach',
            0.62,
            theme.colors.primary,
          ),
          _buildPerformanceRow(
            theme,
            'Local Print Ads',
            0.45,
            theme.colors.warning,
          ),
          _buildPerformanceRow(
            theme,
            'Community Referral',
            0.91,
            theme.colors.info,
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceRow(
    PrimeCareThemeData theme,
    String name,
    double value,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Column(
        children: [
          Row(
            children: [
              Text(name, style: theme.typography.bodyLarge),
              const Spacer(),
              Text(
                '${(value * 10).toStringAsFixed(1)}x ROI',
                style: theme.typography.label,
              ),
            ],
          ),
          SizedBox(height: theme.spacing.xs),
          LinearProgressIndicator(
            value: value,
            backgroundColor: theme.colors.surfaceContainerHighest,
            color: color,
            minHeight: 8,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadConversionFunnel(
    BuildContext context,
    PrimeCareThemeData theme,
  ) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Conversion Velocity', style: theme.typography.titleLarge),
          SizedBox(height: theme.spacing.md),
          _buildFunnelStep(theme, 'New Leads', 124, theme.colors.primary),
          _buildFunnelStep(theme, 'Qualified', 85, theme.colors.info),
          _buildFunnelStep(theme, 'Assessment', 42, theme.colors.warning),
          _buildFunnelStep(theme, 'Contracted', 18, theme.colors.success),
        ],
      ),
    );
  }

  Widget _buildFunnelStep(
    PrimeCareThemeData theme,
    String step,
    int count,
    Color color,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 32,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: theme.spacing.md),
          Text(step, style: theme.typography.bodyLarge),
          const Spacer(),
          Text(
            count.toString(),
            style: theme.typography.h4.copyWith(color: color),
          ),
        ],
      ),
    );
  }

  Widget _buildAuraInsightsColumn(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.dashboards_common_labels_aura_intelligence.tr(), style: theme.typography.h4),
        SizedBox(height: theme.spacing.lg),
        ...insights.map(
          (insight) => Padding(
            padding: EdgeInsets.only(bottom: theme.spacing.md),
            child: IntelligenceInsightCard(insight: insight),
          ),
        ),
      ],
    );
  }
}
