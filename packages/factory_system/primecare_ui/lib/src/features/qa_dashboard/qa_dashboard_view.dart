import 'package:primecare_ui/primecare_ui.dart';
import 'qa_dashboard_controller.dart';
import 'qa_dashboard_model.dart';

class QaDashboardView extends ConsumerWidget {
  const QaDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(qaDashboardAdapterProvider);
    final controller = ref.read(qaDashboardAdapterProvider.notifier);

    return MasterLayout(
      child: state.when(
        data: (result) => result.when(
          (viewModel) => _buildContent(context, theme, viewModel),
          error: (e, st) => DashboardErrorWidget(
            message: 'Governance Error: $e',
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
    QaDashboardViewModel viewModel,
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
                  Text('Quality Assurance Hub', style: theme.typography.h2),
                  Text(
                    'Regulatory compliance, audit telemetry, and clinical incident surveillance',
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
                    _buildComplianceDetails(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildComplianceCharts(theme, viewModel),
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

  Widget _buildComplianceDetails(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Audit Coverage Heatmap - Active Units',
            style: theme.typography.h4,
          ),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'QA Compliance Engine Initialized',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComplianceCharts(
    PrimeCareThemeData theme,
    QaDashboardViewModel viewModel,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_regulatory_compliance_trend.tr(),
          chart: PrimeCareLineChart(
            chart: viewModel.metrics.charts.firstWhere(
              (c) => c.id == 'compliance-trend',
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

class QaDashboardIntent extends PrimeCareScreen {
  QaDashboardIntent() : super(title: "QaDashboard");

  @override
  Widget build(BuildContext context) => const QaDashboardView();
}


