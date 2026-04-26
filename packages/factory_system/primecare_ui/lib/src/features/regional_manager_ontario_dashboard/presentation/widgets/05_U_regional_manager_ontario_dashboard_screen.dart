// Layer: 05_UI_PRESENTATION
import 'package:primecare_ui/primecare_ui.dart';

class RegionalManagerOntarioDashboardScreen extends ConsumerWidget {
  const RegionalManagerOntarioDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalManagerOntarioDashboardAdapterProvider);

    return MasterLayout(
      child: state.whenResult(
        (viewModel) => _buildContent(context, theme, viewModel),
        onRetry: () =>
            ref.refresh(regionalManagerOntarioDashboardAdapterProvider),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalManagerOntarioDashboardViewModel vm,
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
                  Text(
                    'Regional Command Center: Ontario',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'OHIP billing velocity, LHIN compliance, and regional retention tracking',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          GovernedWidget(
            subsystem: PlatformSubsystem.metrics,
            child: PrimeCareResponsiveKpiGrid(metrics: vm.metrics),
          ),
          SizedBox(height: theme.spacing.xl),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    PrimeCareCard(
                      padding: EdgeInsets.all(theme.spacing.xl),
                      child: const Center(
                        child: Text(
                          'Regional Operational Insights Unified',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    _buildRegionalCharts(theme, vm),
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

  Widget _buildRegionalCharts(
    PrimeCareThemeData theme,
    RegionalManagerOntarioDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_regional_ohip_velocity
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'ohip-velocity',
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
            child: GovernedWidget(
              subsystem: PlatformSubsystem.auraAI,
              child: IntelligenceInsightCard(insight: insight),
            ),
          ),
        ),
      ],
    );
  }
}
