import 'package:easy_localization/easy_localization.dart';
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
    IntelligenceInsight(
      id: 'tc_1',
      title: LocaleKeys
          .dashboards_trainingcoordinator_labels_course_efficiency_warning
          .tr(),
      summary:
          '"Cultural Sensitivity" course has a 40% drop-off rate at Module 3.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Engagement',
      recommendation:
          'Review Module 3 assessment complexity or technical video playback issues.',
    ),
    IntelligenceInsight(
      id: 'tc_2',
      title: LocaleKeys
          .dashboards_trainingcoordinator_labels_credentialing_velocity
          .tr(),
      summary:
          'Automated certificate issuance reduced admin time by 15 hours/week.',
      impact: InsightImpact.positive,
      type: InsightType.efficiency,
      category: 'Operations',
      recommendation:
          'Enable auto-renew notifications for all secondary certifications.',
    ),
    IntelligenceInsight(
      id: 'tc_3',
      title: LocaleKeys
          .dashboards_trainingcoordinator_labels_compliance_expiry_risk
          .tr(),
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
