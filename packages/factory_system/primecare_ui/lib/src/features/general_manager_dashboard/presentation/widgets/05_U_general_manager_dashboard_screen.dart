// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class GeneralManagerDashboardScreen extends ConsumerWidget {
  const GeneralManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(generalManagerDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () => ref.refresh(generalManagerDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    GeneralManagerDashboardViewModel vm,
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
                  Text('Operations Command Center', style: theme.typography.h2),
                  Text(
                    'Strategic P&L velocity, capital allocation, and regional operational telemetry',
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
                    _buildStrategicPAndL(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildOperationalCharts(theme, vm),
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

  Widget _buildStrategicPAndL(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Regional Operational Velocity Matrix',
            style: theme.typography.h4,
          ),
          SizedBox(height: theme.spacing.lg),
          Center(
            child: Text(
              'Strategic Allocation Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOperationalCharts(
    PrimeCareThemeData theme,
    GeneralManagerDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys
              .dashboards_common_labels_regional_p_l_overperformance_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'pl-performance',
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
