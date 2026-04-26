import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

/// High-fidelity telemetry stream for the Support Dashboard.
/// Tracks ticket resolution, SLA compliance, and technical volume spikes.
final supportMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  const route = 'SUPPORT';
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

/// High-fidelity AI insights for the Support Dashboard.
/// Surfaces resolution patterns and UX opportunities via Aura Intelligence.
final supportInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  // Simulate AI analysis of ticket trends and customer sentiment
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
      id: 'supp_01',
      title: LocaleKeys.support_dashboard_labels_common_pain_point.tr(),
      summary:
          '60% of current open tickets relate to "Credential Expiry" notifications.',
      impact: InsightImpact.info,
      type: InsightType.alert,
      category: 'UX Optimization',
      recommendation:
          'Update automated email templates to provide clearer renewal steps and reduce helpdesk load.',
    ),
    IntelligenceInsight(
      id: 'supp_02',
      title: LocaleKeys.support_dashboard_labels_resolution_efficiency.tr(),
      summary:
          'Knowledge base articles on "Sync Errors" reduced ticket count by 22%.',
      impact: InsightImpact.positive,
      type: InsightType.efficiency,
      category: 'Self-Service',
      recommendation:
          'Expand Knowledge Base to cover "Mobile Offline Mode" common synchronization issues.',
    ),
    IntelligenceInsight(
      id: 'supp_03',
      title: LocaleKeys.support_dashboard_labels_sla_breach_risk.tr(),
      summary:
          'High volume of "Tier 2 Technical" tickets is approaching SLA limit for Sector 7.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
      category: 'Care Continuity',
      recommendation:
          'Temporarily reallocate 2 support engineers from "General Inquiries" to "Tier 2 Technical" queue.',
    ),
  ];
});

/// Combined adapter provider for the Support Dashboard.
/// Bridges high-fidelity telemetry and support insights into a unified ViewModel.
final supportDashboardAdapterProvider =
    FutureProvider<Result<SupportDashboardViewModel>>((ref) async {
      const cacheKey = 'support_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(supportMetricsProvider.future);
        final insights = await ref.watch(supportInsightsProvider.future);

        final viewModel = SupportDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Support Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            SupportDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          SupportDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });
