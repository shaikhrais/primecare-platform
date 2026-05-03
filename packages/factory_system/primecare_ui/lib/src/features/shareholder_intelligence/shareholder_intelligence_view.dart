// @governance: id=SCREEN_SHAREHOLDER_INTELLIGENCE_DASHBOARD
// @governance: isRenderOk=true
// @governance: userApprovedLayout=true
// @governance: lifecycleStatus=completed
// PRIMECARE CONSOLIDATED FILE
import 'package:primecare_ui/src/features/features_model.dart';
import 'package:primecare_ui/src/features/features_controller.dart';
import 'package:primecare_ui/src/theme/primecare_theme.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart'
    hide isOnlineProvider, ProviderTTL;

class ShareholderIntelligenceView extends ConsumerWidget {
  const ShareholderIntelligenceView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shareholderIntelligenceAdapterProvider);

    return MasterLayout(
      child: state.when(
        data: (result) => result.fold(
          (viewModel) => _buildContent(context, viewModel),
          (e) => DashboardErrorWidget(
            message: 'Governance Error: $e',
            onRetry: () => ref.refresh(shareholderIntelligenceAdapterProvider),
          ),
        ),
        loading: () => const DashboardLoadingWidget(),
        error: (e, st) => DashboardErrorWidget(
          message: 'Connection Error: $e',
          onRetry: () => ref.refresh(shareholderIntelligenceAdapterProvider),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    ShareholderIntelligenceViewModel vm,
  ) {
    final theme = context.theme;
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
                    'Shareholder Intelligence Hub',
                    style: theme.typography.h2,
                  ),
                  Text(
                    'Equity telemetry, valuation analytics, and dividend surveillance',
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
                    _buildEquityMatrixCard(theme),
                    SizedBox(height: theme.spacing.xl),
                    _buildShareholderCharts(theme, vm),
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

  Widget _buildEquityMatrixCard(PrimeCareThemeData theme) {
    return PrimeCareCard(
      padding: EdgeInsets.all(theme.spacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Equity Ownership Matrix', style: theme.typography.h4),
          SizedBox(height: theme.spacing.lg),
          const Center(
            child: Text(
              'Valuation Engine Active',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShareholderCharts(
    PrimeCareThemeData theme,
    ShareholderIntelligenceViewModel vm,
  ) {
    return Column(
      children: [
        PrimeCareChartCard(
          title: 'Valuation Trend',
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
            child: IntelligenceInsightCard(insight: insight),
          ),
        ),
      ],
    );
  }
}

class ShareholderIntelligenceIntent extends PrimeCareScreen {
  ShareholderIntelligenceIntent()
      : super(
          name: 'shareholder_intelligence',
          title: LocaleKeys.dashboards_corporate_shareholder_title,
          route: '/offices/corporate/roles/shareholder/dashboard',
          requiredRole: PlatformRole.shareholder,
          form: PrimeCareForm.shareholderDashboard,
          provider: shareholderIntelligenceAdapterProvider,
          componentLabels: [
            'Aura HUD',
            'Global Header',
            'Stage 1: Initial',
            'Stage 2: In Processing',
            'Stage 3: Implemented',
            'Stage 4: Tested & Done',
            'Telemetry Table',
          ],
        );

  @override
  Widget build(BuildContext context) => const ShareholderIntelligenceView();
}
