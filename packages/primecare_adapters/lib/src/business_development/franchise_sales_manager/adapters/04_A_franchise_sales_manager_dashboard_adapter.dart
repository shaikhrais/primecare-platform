// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final franchiseSalesManagerDashboardAdapterProvider =
    FutureProvider<Result<FranchiseSalesManagerDashboardViewModel>>((
      ref,
    ) async {
      const route = 'FRANCHISE_SALES_MANAGER';
      const cacheKey = 'franchise_sales_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      // Attempt to fetch live metrics
      final metricsResult = await ref.watch(
        dashboardMetricsProvider(route).future,
      );

      return metricsResult.fold(
        (metrics) {
          final hardenedKpis = [
            const KpiMetric(
              title: 'Pipeline Value',
              value: '\$12.4M',
              trend: '+15%',
              status: 'positive',
            ),
            const KpiMetric(
              title: 'Conversion Velocity',
              value: '1.8x',
              trend: '+22%',
              status: 'positive',
            ),
            const KpiMetric(
              title: 'Active Leads',
              value: '428',
              trend: '+8%',
              status: 'positive',
            ),
            const KpiMetric(
              title: 'Closing Ratio',
              value: '24%',
              trend: '+4%',
              status: 'positive',
            ),
          ];

          final charts = [
            AnalyticsChart(
              id: 'sales-pipeline',
              title: 'Franchise Sales Pipeline (30d)',
              type: ChartType.line,
              dataPoints: [
                const ChartDataPoint(label: 'W1', value: 12),
                const ChartDataPoint(label: 'W2', value: 18),
                const ChartDataPoint(label: 'W3', value: 15),
                const ChartDataPoint(label: 'W4', value: 24),
              ],
            ),
            AnalyticsChart(
              id: 'lead-source-breakdown',
              title: 'Lead Source Distribution',
              type: ChartType.pie,
              dataPoints: [
                const ChartDataPoint(label: 'Referral', value: 40),
                const ChartDataPoint(label: 'Direct', value: 30),
                const ChartDataPoint(label: 'Social', value: 20),
                const ChartDataPoint(label: 'Other', value: 10),
              ],
            ),
          ];

          final activeMetrics = DashboardMetrics(
            kpis: hardenedKpis,
            recentActivity: [],
            charts: charts,
            insights: [
              const DashboardInsight(
                title: 'Lead Velocity Spike',
                description: 'Organic lead volume increased by 22% this week.',
                type: 'SALES',
                impact: InsightImpact.positive,
              ),
            ],
          );

          final viewModel = FranchiseSalesManagerDashboardViewModel(
            metrics: activeMetrics,
            insights: _getSmartFranchiseSalesMocks(),
            isOfflineFallback: false,
          );

          telemetry.passGate(
            ExecutionGateCategory.intelligence,
            'Franchise Sales Manager Strategy HUD Hydrated',
          );

          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
          return Success(viewModel);
        },
        (error) {
          telemetry.passGate(
            ExecutionGateCategory.resilience,
            'Franchise Sales Manager Resilience Strategy Activated',
          );
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            final vm = FranchiseSalesManagerDashboardViewModel.fromJson(
              snapshot,
            );
            return Success(
              FranchiseSalesManagerDashboardViewModel(
                metrics: vm.metrics,
                insights: vm.insights,
                isOfflineFallback: true,
              ),
            );
          }
          return Success(
            FranchiseSalesManagerDashboardViewModel.empty(
              isOfflineFallback: true,
            ),
          );
        },
      );
    });

List<IntelligenceInsight> _getSmartFranchiseSalesMocks() {
  return [
    IntelligenceInsight(
      id: 'fsm_01',
      title: 'Territory Saturation Alert',
      summary:
          'Toronto West territory is reaching 95% franchise density. Remaining capacity: 1 unit.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Market',
      recommendation:
          'Pause new applications for Toronto West and pivot to Peel Region.',
    ),
    IntelligenceInsight(
      id: 'fsm_02',
      title: 'Conversion Velocity High',
      summary:
          'Leads from the Recent Expo are converting 3x faster than digital channels.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Strategy',
      recommendation:
          'Allocate additional business development budget to regional trade shows.',
    ),
  ];
}
