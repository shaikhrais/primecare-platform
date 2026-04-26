import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final regionalBdmDashboardAdapterProvider =
    FutureProvider<Result<RegionalBdmDashboardViewModel>>((ref) async {
      const route = 'RegionalBdm';
      const cacheKey = 'regional_bdm_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);
      final metricsResult = await ref.watch(
        dashboardMetricsProvider(route).future,
      );

      return metricsResult.fold(
        (metrics) {
          final viewModel = RegionalBdmDashboardViewModel(
            metrics: metrics,
            insights: _getSmartRegionalBdmMocks(),
            isOfflineFallback: false,
          );

          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

          telemetry.passGate(
            ExecutionGateCategory.intelligence,
            'Regional BDM Growth Intelligence Mapping Successful',
          );
          return Success(viewModel);
        },
        (error) {
          telemetry.passGate(
            ExecutionGateCategory.resilience,
            'Regional BDM Fallback Triggered',
          );
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(RegionalBdmDashboardViewModel.fromJson(snapshot));
          }
          return Success(
            RegionalBdmDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

List<IntelligenceInsight> _getSmartRegionalBdmMocks() {
  return [
    IntelligenceInsight(
      id: 'rbdm_01',
      title: LocaleKeys.dashboards_regionalbdm_labels_market_penetration_high
          .tr(),
      summary:
          'Referral capture in the Greater Area has exceeded target by 15%.',
      impact: InsightImpact.positive,
      type: InsightType.standard,
      recommendation:
          'Reallocate business development resources to the Northern sector.',
    ),
    IntelligenceInsight(
      id: 'rbdm_02',
      title: LocaleKeys.dashboards_regionalbdm_labels_lead_velocity_decay.tr(),
      summary: 'Initial lead response times have increased to 4.2 hours.',
      impact: InsightImpact.warning,
      type: InsightType.efficiency,
      recommendation:
          'Automate initial outreach for new inquiries to drop response time below 1 hour.',
    ),
  ];
}
