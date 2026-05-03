// @governance: id=SCREEN_CX_DIRECTOR_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed

    hide isOnlineProvider, ProviderTTL;

// @governance: component=Aura HUD (Experience Velocity)
// @governance: component=Sentiment Scorecard
// @governance: component=Retention Analysis
// @governance: component=Customer Journey Drift
class CxDirectorDashboardView extends ConsumerWidget {
  const CxDirectorDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(cxDirectorDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (vm) =>
              _buildContent(context, theme, vm as CXDirectorDashboardViewModel),
          (e) => DashboardErrorWidget(
            message: 'Experience Error: $e',
            onRetry: () => ref.refresh(cxDirectorDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(cxDirectorDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    CXDirectorDashboardViewModel vm,
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
                    LocaleKeys.cx_director_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.cx_director_dashboard_subtitle.tr(),
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
                    _buildSentimentHeatmap(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildExperienceCharts(theme, vm),
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

  Widget _buildSentimentHeatmap(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Sentiment Velocity Heatmap', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Global Experience Surveillance Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCharts(
    PrimeCareThemeData theme,
    CXDirectorDashboardViewModel vm,
  ) {
    final sentimentChart = vm.metrics.charts.firstWhere(
      (c) => c.id == 'sentiment-trend',
      orElse: () => AnalyticsChart.empty(),
    );

    if (sentimentChart.id.isEmpty) return const SizedBox.shrink();

    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_sentiment_velocity_trend
              .tr(),
          chart: PrimeCareLineChart(chart: sentimentChart),
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

class CxDirectorDashboardIntent extends PrimeCareScreen {
  CxDirectorDashboardIntent()
      : super(
          name: 'cx_director_dashboard',
          title: LocaleKeys.cx_director_dashboard_title,
          route: '/corporate/experience/intelligence',
          requiredRole: PlatformRole.cxDirector,
          form: PrimeCareForm.cxDirectorDashboard,
          provider: cxDirectorDashboardAdapterProvider,
          componentLabels: const ['Aura HUD', 'Experience Surveillance'],
        );

  @override
  Widget build(BuildContext context) => const CxDirectorDashboardView();
}
