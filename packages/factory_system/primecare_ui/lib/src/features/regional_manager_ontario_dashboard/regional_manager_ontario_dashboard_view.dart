import 'package:primecare_ui/primecare_ui.dart';
import 'regional_manager_ontario_dashboard_controller.dart';
import 'regional_manager_ontario_dashboard_model.dart';

class RegionalManagerOntarioDashboardView extends ConsumerWidget {
  const RegionalManagerOntarioDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(regionalManagerOntarioDashboardAdapterProvider);
    final controller = ref.read(regionalManagerOntarioDashboardAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'Ontario Governance Error: $e',
            onRetry: controller.refresh,
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: controller.refresh,
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    RegionalManagerOntarioDashboardViewModel viewModel,
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
              if (viewModel.isOfflineFallback) const OfflineStatusChip(),
            ],
          ),
          SizedBox(height: theme.spacing.xl),

          GovernedWidget(
            subsystem: PlatformSubsystem.metrics,
            child: PrimeCareResponsiveKpiGrid(metrics: viewModel.metrics),
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
                    _buildRegionalCharts(theme, viewModel),
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

  Widget _buildRegionalCharts(
    PrimeCareThemeData theme,
    RegionalManagerOntarioDashboardViewModel viewModel,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_regional_ohip_velocity.tr(),
          chart: PrimeCareLineChart(
            chart: viewModel.metrics.charts.firstWhere(
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

class RegionalManagerOntarioDashboardIntent extends PrimeCareScreen {
  RegionalManagerOntarioDashboardIntent() : super(title: "RegionalManagerOntarioDashboard");

  @override
  Widget build(BuildContext context) => const RegionalManagerOntarioDashboardView();
}


