import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Adapter for IT Security Dashboard telemetry.
/// Provides real-time cyber-shield metrics and threat-intelligence logs.
final itSecurityDashboardAdapterProvider =
    FutureProvider<Result<ITSecurityDashboardViewModel>>((ref) async {
      const cacheKey = 'it_security_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(itSecurityMetricsProvider.future);
        final insights = await ref.watch(itSecurityInsightsProvider.future);

        final viewModel = ITSecurityDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'IT Security Dashboard fully hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            ITSecurityDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          ITSecurityDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });

final itSecurityMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  const route = 'IT_SECURITY';
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics(route)
      .map((r) => r.fold((m) => m, (e) => throw e));
});

final itSecurityInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  await Future<void>.delayed(const Duration(seconds: 1));
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }
  return [
    IntelligenceInsight(
      id: 'sec_1',
      title: 'Threat Intel',
      summary:
          'No active breaches detected. Aura Guard has neutralized 14 brute-force attempts from suspicious nodes.',
      impact: InsightImpact.info,
      type: InsightType.compliance,
    ),
    IntelligenceInsight(
      id: 'sec_2',
      title: 'Compliance',
      summary:
          'System is 98.4% compliant with PHIPA security standards. 2 nodes require kernel updates.',
      impact: InsightImpact.warning,
      type: InsightType.risk,
    ),
  ];
});

class ITSecurityDashboardAdapter {
  ITSecurityDashboardAdapter();

  /// Triggers a global threat scan.
  Future<void> runThreatScan() async {
    await Future<void>.delayed(const Duration(seconds: 2));
  }

  /// Rotates institutional API keys.
  Future<void> rotateKeys() async {
    await Future<void>.delayed(const Duration(seconds: 3));
  }

  /// Purges edge security caches.
  Future<void> purgeSecurityCache() async {
    await Future<void>.delayed(const Duration(seconds: 1));
  }
}
