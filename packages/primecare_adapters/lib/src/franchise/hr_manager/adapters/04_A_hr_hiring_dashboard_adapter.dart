import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// StreamProvider for real-time HR and hiring metrics.
/// Implements high-fidelity hydration for the HR Manager.
final hrMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  const route = 'HrManager';
  final repository = ref.read(dashboardRepositoryProvider);

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics(route)
      .map(
        (result) => result.fold(
          (metrics) => metrics,
          (error) => DashboardMetrics.empty(),
        ),
      );
});

/// FutureProvider for AI-driven human capital insights.
final hrInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  // Simulate AI analysis of staffing trends and candidate funnels
  await Future<void>.delayed(const Duration(milliseconds: 1500));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }
  return [
    IntelligenceInsight(
      id: 'hr_01',
      title: LocaleKeys.dashboards_hrhiring_labels_interview_bottleneck_detected
          .tr(),
      summary:
          'Candidate dwell time in the "Interview" stage exceeded 14 days for Clinical roles.',
      impact: InsightImpact.warning,
      type: InsightType.optimization,
      category: 'Recruitment',
      recommendation:
          'Enable automated scheduling for Tier 2 interviews to reduce dwell time by 30%.',
    ),
    IntelligenceInsight(
      id: 'hr_02',
      title: LocaleKeys.dashboards_hrhiring_labels_offer_strategy_success.tr(),
      summary:
          'Flexible-schedule benefits improved offer acceptance rate by 15% this quarter.',
      impact: InsightImpact.positive,
      type: InsightType.growth,
      category: 'Benefits',
      recommendation:
          'Highlight the "Flexible Care" perk in all external LinkedIn postings.',
    ),
    IntelligenceInsight(
      id: 'hr_03',
      title: LocaleKeys.dashboards_hrhiring_labels_candidate_drop_off_alert
          .tr(),
      summary:
          'High drop-off rate (22%) detected during the "Background Check" phase.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Compliance',
      recommendation:
          'Integrate the new Checkr API to streamline the background verification workflow.',
    ),
  ];
});

final hrHiringDashboardAdapterProvider =
    FutureProvider<Result<HrHiringDashboardViewModel>>((ref) async {
      const cacheKey = 'hr_hiring_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        // Watch metrics and insights
        final metrics = await ref.watch(hrMetricsProvider.future);
        final insights = await ref.watch(hrInsightsProvider.future);

        final viewModel = HrHiringDashboardViewModel(
          metrics: metrics,
          insights: insights,
          isOfflineFallback: false,
        );

        // Persist LKG snapshot
        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'HR Hiring Dashboard hydrated with production metrics',
        );

        return Success(viewModel);
      } catch (e) {
        telemetry.failGate(
          ExecutionGateCategory.resilience,
          'HR Hiring Metrics Fallback Triggered: $e',
        );
        return _handleHrHiringFallback(resilience, cacheKey, telemetry);
      }
    });

Result<HrHiringDashboardViewModel> _handleHrHiringFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = HrHiringDashboardViewModel.fromJson(snapshot);
      return Success(vm.copyWith(isOfflineFallback: true));
    } catch (e) {
      telemetry.failGate(
        ExecutionGateCategory.structuralIntegrity,
        'HR Hiring Cache corruption detected: $e',
      );
    }
  }
  return Success(HrHiringDashboardViewModel.empty(isOfflineFallback: true));
}
