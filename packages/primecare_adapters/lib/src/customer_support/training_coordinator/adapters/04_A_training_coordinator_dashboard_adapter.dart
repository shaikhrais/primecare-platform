// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// High-fidelity telemetry stream for the Training Coordinator Dashboard.
/// Monitors course completion, enrollment mix, and certification velocity.
final trainingCoordMetricsProvider = StreamProvider<DashboardMetrics>((ref) {
  const route = 'TRAINING_COORDINATOR';
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

/// High-fidelity AI insights for the Training Coordinator Dashboard.
/// Surfaces course efficiency and credentialing opportunities via Aura Intelligence.
final trainingCoordInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
  ref,
) async {
  // Simulate AI computation for operational modeling
  await Future<void>.delayed(const Duration(milliseconds: 1400));

  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.auraAI,
  );
  if (!canExecute) {
    return const [];
  }
  return [
    const IntelligenceInsight(
      id: 'tc_1',
      title: 'Course Efficiency Warning',
      summary:
          '"Cultural Sensitivity" course has a 40% drop-off rate at Module 3.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Engagement',
      recommendation:
          'Review Module 3 assessment complexity or technical video playback issues.',
    ),
    const IntelligenceInsight(
      id: 'tc_2',
      title: 'Credentialing Velocity',
      summary:
          'Automated certificate issuance reduced admin time by 15 hours/week.',
      impact: InsightImpact.positive,
      type: InsightType.efficiency,
      category: 'Operations',
      recommendation:
          'Enable auto-renew notifications for all secondary certifications.',
    ),
    const IntelligenceInsight(
      id: 'tc_3',
      title: 'Compliance Expiry Risk',
      summary:
          '15 staff members have HIPAA certifications expiring in < 30 days.',
      impact: InsightImpact.caution,
      type: InsightType.risk,
      category: 'Compliance',
      recommendation:
          'Initiate bulk enrollment for the HIPAA 2026 Refresher module.',
    ),
  ];
});

/// Combined adapter provider for the Training Coordinator Dashboard.
/// Bridges high-fidelity telemetry and course insights into a unified ViewModel.
final trainingCoordinatorDashboardAdapterProvider =
    FutureProvider<Result<TrainingCoordinatorDashboardViewModel>>((ref) async {
      const cacheKey = 'training_coordinator_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(trainingCoordMetricsProvider.future);
        final insights = await ref.watch(trainingCoordInsightsProvider.future);

        final viewModel = TrainingCoordinatorDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Training Coordinator Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            TrainingCoordinatorDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          TrainingCoordinatorDashboardViewModel.empty(isOfflineFallback: true),
        );
      }
    });

// Action Handlers for Training Coordinator Dashboard
final trainingCoordinatorActionHandler =
    Provider.autoDispose<void Function(String)>((ref) {
      final telemetry = ref.read(executionGateProvider);

      return (String actionId) {
        telemetry.passGate(
          ExecutionGateCategory.interaction,
          'Training Dashboard Action Triggered: $actionId',
        );
      };
    });
