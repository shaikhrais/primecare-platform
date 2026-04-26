// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterDashboardScreen extends ConsumerWidget {
  const ScrumMasterDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(scrumMasterDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () => ref.refresh(scrumMasterDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ScrumMasterDashboardViewModel vm,
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
                  Text('Agile Command Center', style: theme.typography.h2),
                  Text(
                    'Sprint velocity, burndown telemetry, and delivery risk analysis',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildAgileVelocityCard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildDeliveryCharts(theme, vm),
                  ],
                ),
              ),
              if (vm.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(child: _buildAuraInsightsColumn(theme, vm.insights)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAgileVelocityCard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sprint Burndown - Active Cycle', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          Center(
            child: Text(
              'Dynamic Agile Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliveryCharts(
    PrimeCareThemeData theme,
    ScrumMasterDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_sprint_velocity_trend.tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'sprint-velocity',
              orElse: () => AnalyticsChart.empty(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAuraInsightsColumn(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.dashboards_common_labels_aura_intelligence.tr(),
          style: theme.typography.h4,
        ),
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
