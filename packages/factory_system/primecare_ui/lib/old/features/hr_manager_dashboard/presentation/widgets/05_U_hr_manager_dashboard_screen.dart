// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class HrManagerDashboardScreen extends ConsumerWidget {
  const HrManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(hrHiringDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () => ref.refresh(hrHiringDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    HrHiringDashboardViewModel vm,
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
                  Text('Human Capital Command', style: theme.typography.h2),
                  Text(
                    'Workforce stability, payroll velocity, and compliance telemetry',
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
                    _buildStaffingVelocity(theme),
                    SizedBox(height: theme.spacing.xl),
                    HiringFunnelGrid(),
                    SizedBox(height: theme.spacing.xl),
                    HrActionHub(),
                  ],
                ),
              ),
              if (vm.insights.isNotEmpty) ...[
                SizedBox(width: theme.spacing.xl),
                Expanded(child: _buildIntelligenceSection(theme, vm.insights)),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStaffingVelocity(PrimeCareThemeData theme) {
    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_staffing_velocity_matrix.tr(),
      chart: PrimeCareLineChart(
        chart: AnalyticsChart(
          id: 'hiring_trend',
          title: LocaleKeys.dashboards_common_labels_velocity_score.tr(),
          type: ChartType.line,
          dataPoints: [
            ChartDataPoint(label: 'Jan', value: 42),
            ChartDataPoint(label: 'Feb', value: 38),
            ChartDataPoint(label: 'Mar', value: 54),
            ChartDataPoint(label: 'Apr', value: 62),
            ChartDataPoint(label: 'May', value: 58),
            ChartDataPoint(label: 'Jun', value: 71),
          ],
        ),
      ),
    );
  }

  Widget _buildIntelligenceSection(
    PrimeCareThemeData theme,
    List<IntelligenceInsight> insights,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Capital Intelligence', style: theme.typography.h4),
        SizedBox(height: theme.spacing.md),
        Column(
          children: insights
              .map(
                (insight) => Padding(
                  padding: EdgeInsets.only(bottom: theme.spacing.md),
                  child: IntelligenceInsightCard(insight: insight),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class HiringFunnelGrid extends StatelessWidget {
  HiringFunnelGrid({super.key});
  @override
  Widget build(BuildContext context) => PrimeCareCard(
    child: Center(
      child: Text(
        LocaleKeys.dashboards_common_labels_active_hiring_funnel.tr(),
      ),
    ),
  );
}
