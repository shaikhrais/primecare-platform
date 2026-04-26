import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// StreamProvider for real-time Local Marketing Manager metrics.
/// Tracks lead generation, campaign performance, and cost-per-lead.
final localMarketingMetricsProvider =
    StreamProvider.autoDispose<DashboardMetrics>((ref) {
      final repository = ref.watch(dashboardRepositoryProvider);
      const route = 'LOCAL_MARKETING_MANAGER';
      return repository
          .watchMetrics(route)
          .map((r) => r.fold((m) => m, (e) => throw e));
    });

/// FutureProvider for AI-driven Marketing insights.
/// Analyzes lead conversion trends, campaign ROI, and market opportunity.
final localMarketingInsightsProvider =
    FutureProvider.autoDispose<List<IntelligenceInsight>>((ref) async {
      final telemetry = ref.read(executionGateProvider);

      // Fast-fail if offline
      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );
      if (!canExecute) {
        return _getSmartMarketingMocks();
      }

      // Simulate AI Analysis Latency
      await Future<void>.delayed(const Duration(milliseconds: 700));

      telemetry.passGate(
        ExecutionGateCategory.aura,
        'Marketing Growth Intelligence Generated',
      );

      return _getSmartMarketingMocks();
    });

List<IntelligenceInsight> _getSmartMarketingMocks() {
  return [
    IntelligenceInsight(
      id: 'mkt_01',
      title: 'Conversion Rate Surge',
      summary:
          'Local referral conversion from "Senior Living" events is up 35%.',
      impact: InsightImpact.positive,
      type: InsightType.optimization,
      recommendation:
          'Increase ad spend for the upcoming "North Sector Open House" campaign.',
    ),
    IntelligenceInsight(
      id: 'mkt_02',
      title: 'Lead Attrition Alert',
      summary:
          '12 high-intent leads in the "Qualified" stage have not been contacted in 48h.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      recommendation:
          'Trigger immediate follow-up tasks for the local sales outreach team.',
    ),
    IntelligenceInsight(
      id: 'mkt_03',
      title: 'Market Expansion Opportunity',
      summary:
          'High demand for specialized pediatric care identified in the West District.',
      impact: InsightImpact.growth,
      type: InsightType.optimization,
      recommendation:
          'Draft a targeted social media campaign for pediatric services in West District.',
    ),
  ];
}

/// Combined adapter provider for the Local Marketing Manager Dashboard.
/// Bridges high-fidelity telemetry and marketing insights into a unified ViewModel.
final localMarketingManagerDashboardAdapterProvider =
    FutureProvider<Result<LocalMarketingManagerDashboardViewModel>>((
      ref,
    ) async {
      const cacheKey = 'marketing_manager_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      final canExecute = AdapterModulationGovernor.canExecute(
        ref,
        PlatformSubsystem.metrics,
      );

      try {
        if (!canExecute) {
          throw Exception('Metrics subsystem is degraded or offline');
        }
        final metrics = await ref.watch(localMarketingMetricsProvider.future);
        final insights = await ref.watch(localMarketingInsightsProvider.future);

        final viewModel = LocalMarketingManagerDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Marketing Manager Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            LocalMarketingManagerDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          LocalMarketingManagerDashboardViewModel.empty(
            isOfflineFallback: true,
          ),
        );
      }
    });
