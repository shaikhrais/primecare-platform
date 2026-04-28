// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class ClinicalDirectorDashboardView extends ConsumerWidget {
  const ClinicalDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(clinicalDirectorDashboardAdapterProvider);
    final controller = ClinicalDirectorDashboardController(ref);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as ClinicalDirectorViewModel,
            controller,
          ),
          (e) => DashboardErrorWidget(
            message: 'Clinical Error: $e',
            onRetry: () =>
                ref.refresh(clinicalDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(clinicalDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    ClinicalDirectorViewModel vm,
    ClinicalDirectorDashboardController controller,
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
                    'Clinical Director Command Center',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Clinical outcomes, patient safety, and quality assurance telemetry',
                    style: theme.typography.labelMedium,
                  ),
                ],
              ),
              const Spacer(),
              if (vm.isOfflineFallback) const OfflineStatusChip(),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refresh,
              ),
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
                    _buildClinicalPerformance(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildIncidentTrends(theme, vm),
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

  Widget _buildClinicalPerformance(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clinical Quality Performance', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Patient Outcomes Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentTrends(
    PrimeCareThemeData theme,
    ClinicalDirectorViewModel vm,
  ) {
    return PrimeCareChartCard(
      title: LocaleKeys.dashboards_common_labels_safety_incident_velocity.tr(),
      chart: PrimeCareLineChart(
        chart: vm.metrics.charts.firstWhere(
          (c) => c.id == 'incident-trends',
          orElse: () => AnalyticsChart.empty(),
        ),
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

class ClinicalDirectorDashboardIntent extends PrimeCareScreen {
  ClinicalDirectorDashboardIntent() : super(title: 'ClinicalDirectorDashboard');

  @override
  Widget build(BuildContext context) => const ClinicalDirectorDashboardView();
}
