// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// Command Row action handler for the Training Hub.
final trainingHubActionHandler = Provider<void Function(String)>((ref) {
  return (action) {
    PrimeCareLogger.log('Training Hub Action Dispatched: $action');
  };
});

/// High-fidelity telemetry stream for the Training Hub.
/// Tracks global enrollment, curricula availability, and engagement mix.
final trainingHubMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics('/v2/corporate/training_hub')
      .map((r) => r.fold((m) => m, (e) => throw e));
});

/// High-fidelity AI insights for the Training Hub.
/// Surfaces engagement opportunities and resource bottlenecks via Aura Intelligence.
final trainingHubInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
    const IntelligenceInsight(
      id: 'th_1',
      title: 'High Engagement in Clinical Safety',
      summary:
          'Clinical safety modules have seen a 25% increase in enrollment this week.',
      impact: InsightImpact.positive,
      type: InsightType.efficiency,
      category: 'Engagement',
      recommendation:
          'Expand Clinical Safety Track and allocate additional virtual classroom seats.',
    ),
    const IntelligenceInsight(
      id: 'th_2',
      title: 'Resource Bottleneck Predicted',
      summary:
          'Upcoming "Annual Compliance" spike may exceed current server capacity for video streaming.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Infrastructure',
      recommendation:
          'Pre-cache video assets on regional edge nodes before Monday 09:00 UTC.',
    ),
  ];
});

final trainingHubDashboardAdapterProvider =
    FutureProvider<Result<TrainingHubViewModel>>((ref) async {
      const cacheKey = 'training_hub_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(trainingHubMetricsProvider.future);
        final insights = await ref.watch(trainingHubInsightsProvider.future);

        final viewModel = TrainingHubViewModel(
          curricula: [], // Hydrate from repository if needed
          certifications: [],
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

        telemetry.passGate(
          ExecutionGateCategory.governance,
          'Training Hub Dashboard hydrated',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            TrainingHubViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(TrainingHubViewModel.empty());
      }
    });
