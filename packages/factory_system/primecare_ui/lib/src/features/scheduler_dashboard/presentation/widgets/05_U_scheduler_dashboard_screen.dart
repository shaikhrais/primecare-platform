// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class SchedulerDashboardScreen extends ConsumerWidget {
  const SchedulerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(schedulerDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () => ref.refresh(schedulerDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    SchedulerDashboardViewModel vm,
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
                  Text('Logistics Command Center', style: theme.typography.h2),
                  Text(
                    'Staffing velocity, shift coverage, and travel optimization telemetry',
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
                    _buildLogisticsCard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildStaffingCharts(theme, vm),
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

  Widget _buildLogisticsCard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Staffing Grid - Active Clusters', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Dynamic Logistics Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffingCharts(
    PrimeCareThemeData theme,
    SchedulerDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: 'Shift Coverage Velocity',
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'coverage-velocity',
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
        Text('Aura Intelligence', style: theme.typography.h4),
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
