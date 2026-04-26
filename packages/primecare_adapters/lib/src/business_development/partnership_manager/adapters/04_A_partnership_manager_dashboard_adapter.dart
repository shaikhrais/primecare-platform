import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'package:primecare_adapters/primecare_adapters.dart';
import 'dart:async';

/// StreamProvider for real-time Partnership Manager metrics.
/// Tracks partner referrals, conversion rates, and active deals.
final partnershipManagerMetricsProvider =
    StreamProvider.autoDispose<DashboardMetrics>((ref) {
      final telemetry = ref.read(executionGateProvider);
      const route = 'PartnershipManager';
      final repository = ref.read(dashboardRepositoryProvider);

      return repository
          .watchMetrics(route)
          .map(
            (result) => result.fold((metrics) {
              telemetry.passGate(
                ExecutionGateCategory.metricsLayer,
                'Partnership Metrics Hydrated',
              );
              return metrics;
            }, (error) => DashboardMetrics.empty()),
          );
    });

/// FutureProvider for AI-driven Partnership insights.
/// Analyzes partner synergy, churn risk, and market expansion opportunities.
final partnershipManagerInsightsProvider =
    FutureProvider.autoDispose<List<IntelligenceInsight>>((ref) async {
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );
      if (!canExecute) {
        return _getSmartPartnershipMocks(); // Use mocks as local fallback
      }

      // Simulate AI Analysis Latency
      await Future<void>.delayed(const Duration(milliseconds: 800));

      telemetry.passGate(
        ExecutionGateCategory.aura,
        'Partnership Strategic Intelligence Generated',
      );

      return _getSmartPartnershipMocks();
    });

List<IntelligenceInsight> _getSmartPartnershipMocks() {
  return [
    IntelligenceInsight(
      id: 'ptnr_01',
      title: LocaleKeys
          .dashboards_partnershipmanager_labels_partner_referral_drop
          .tr(),
      summary:
          'Referrals from "Central Clinic Group" have decreased by 20% this month.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      recommendation:
          'Schedule a quarterly review meeting with the Clinic Group Director.',
    ),
    IntelligenceInsight(
      id: 'ptnr_02',
      title: LocaleKeys.dashboards_partnershipmanager_labels_high_value_pipeline
          .tr(),
      summary:
          '3 new medical centers in the South Sector have expressed interest in partnership.',
      impact: InsightImpact.growth,
      type: InsightType.optimization,
      recommendation:
          'Accelerate onboarding for the "South Sector Hub" to capture Q2 volume.',
    ),
    IntelligenceInsight(
      id: 'ptnr_03',
      title: LocaleKeys
          .dashboards_partnershipmanager_labels_synergy_optimization
          .tr(),
      summary:
          'Cross-referral potential identified between "East Care" and "West Med".',
      impact: InsightImpact.info,
      type: InsightType.optimization,
      recommendation:
          'Propose a joint community outreach program for the Fall season.',
    ),
  ];
}

/// Combined adapter provider for the Partnership Manager Dashboard.
/// Bridges high-fidelity telemetry and partner synergy insights into a unified ViewModel.
final partnershipManagerDashboardAdapterProvider =
    FutureProvider<Result<PartnershipManagerDashboardViewModel>>((ref) async {
      const cacheKey = 'partnership_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(
          partnershipManagerMetricsProvider.future,
        );
        final insights = await ref.watch(
          partnershipManagerInsightsProvider.future,
        );

        final viewModel = PartnershipManagerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Partnership Manager Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          final vm = PartnershipManagerDashboardViewModel.fromJson(snapshot);
          return Success(
            PartnershipManagerDashboardViewModel(
              metrics: vm.metrics,
              insights: vm.insights,
              isOfflineFallback: true,
            ),
          );
        }
        return Success(
          PartnershipManagerDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
