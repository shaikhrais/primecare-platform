// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// @governance: component=Aura HUD
// @governance: component=Portfolio Yield
// @governance: component=Equity Growth Heatmap
// @governance: component=Strategic Risk Matrix

    hide isOnlineProvider, ProviderTTL;

class OwnerDashboardView extends ConsumerWidget {
  const OwnerDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final state = ref.watch(ownerDashboardAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(
            context,
            theme,
            viewModel as OwnerDashboardViewModel,
          ),
          (e) => DashboardErrorWidget(
            message: 'Owner Governance Error: $e',
            onRetry: () => ref.refresh(ownerDashboardAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(ownerDashboardAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    PrimeCareThemeData theme,
    OwnerDashboardViewModel vm,
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
                    LocaleKeys.owner_dashboard_title.tr(),
                    style: theme.typography.h2,
                  ),
                  Text(
                    LocaleKeys.owner_dashboard_subtitle.tr(),
                    style: theme.typography.bodyLarge,
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
                          'Operational Insights Unified',
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    SizedBox(height: theme.spacing.xl),
                    _buildSecondaryCharts(theme, vm),
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

  Widget _buildSecondaryCharts(
    PrimeCareThemeData theme,
    OwnerDashboardViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: LocaleKeys.dashboards_common_labels_enterprise_valuation_trend
              .tr(),
          chart: PrimeCareLineChart(
            chart: vm.metrics.charts.firstWhere(
              (c) => c.id == 'valuation-trend',
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

class OwnerDashboardIntent extends PrimeCareScreen {
  OwnerDashboardIntent()
      : super(
          name: 'owner_dashboard',
          title: LocaleKeys.owner_dashboard_title,
          route: '/offices/roles/owner/dashboard',
          requiredRole: PlatformRole.owner,
          form: PrimeCareForm.ownerDashboard,
          provider: ownerDashboardAdapterProvider,
          componentLabels: const [
            'Aura HUD',
            'Portfolio Yield',
            'Equity Growth Heatmap',
            'Strategic Risk Matrix',
          ],
        );

  @override
  Widget build(BuildContext context) => const OwnerDashboardView();
}
