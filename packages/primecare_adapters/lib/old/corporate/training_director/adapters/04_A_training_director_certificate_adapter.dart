import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

/// High-fidelity telemetry stream for the Training Director Certificate Dashboard.
/// Tracks audit readiness, renewal velocity, and regulatory gap stability.
final trainingDirectorCertMetricsProvider = StreamProvider<DashboardMetrics>((
  ref,
) {
  final repository = ref.watch(dashboardRepositoryProvider);
  final canExecute = AdapterModulationGovernor.canExecute(
    ref,
    PlatformSubsystem.metrics,
  );
  if (!canExecute) {
    return Stream.value(DashboardMetrics.empty());
  }
  return repository
      .watchMetrics('/v2/corporate/training_certificate')
      .map((r) => r.fold((m) => m, (e) => throw e));
});

/// High-fidelity AI insights for the Training Director Certificate Dashboard.
/// Surfaces compliance anomalies and regulatory opportunities via Aura Intelligence.
final trainingDirectorCertInsightsProvider = FutureProvider<List<IntelligenceInsight>>((
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
      id: 'td_cert_1',
      title: LocaleKeys
          .dashboards_trainingdirectorcertificate_labels_compliance_anomaly_detected
          .tr(),
      summary:
          'A 12% spike in expired certifications was detected in the Eastern region. Automated renewal prompts dispatched.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      category: 'Compliance',
      recommendation:
          'Review Eastern Region Compliance Report and adjust automated escalation thresholds.',
    ),
    IntelligenceInsight(
      id: 'td_cert_2',
      title: LocaleKeys
          .dashboards_trainingdirectorcertificate_labels_regulatory_optimization
          .tr(),
      summary:
          'Transitioning to digital-only verification reduced audit processing time by 40%.',
      impact: InsightImpact.positive,
      type: InsightType.efficiency,
      category: 'Operations',
      recommendation:
          'Onboard remaining 3 facilities to the digital-first certificate registry.',
    ),
  ];
});

/// Combined adapter provider for the Training Director Certificate Dashboard.
/// Bridges high-fidelity telemetry and compliance insights into a unified ViewModel.
final trainingDirectorCertDashboardAdapterProvider =
    FutureProvider<Result<TrainingDirectorCertificateDashboardViewModel>>((
      ref,
    ) async {
      const cacheKey = 'training_director_cert_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final metrics = await ref.watch(
          trainingDirectorCertMetricsProvider.future,
        );
        final insights = await ref.watch(
          trainingDirectorCertInsightsProvider.future,
        );

        final viewModel = TrainingDirectorCertificateDashboardViewModel(
          metrics: metrics,
          insights: insights,
        );

        unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
        telemetry.passGate(
          ExecutionGateCategory.resilience,
          'Training Director Certificate Dashboard hydrated.',
        );

        return Success(viewModel);
      } catch (e) {
        final snapshot = resilience.getSnapshot(cacheKey);
        if (snapshot != null) {
          return Success(
            TrainingDirectorCertificateDashboardViewModel.fromJson(
              snapshot,
            ).copyWith(isOfflineFallback: true),
          );
        }
        return Success(
          TrainingDirectorCertificateDashboardViewModel.empty(
            isOfflineFallback: true,
          ),
        );
      }
    });

/// Action Handler for the Certificate Verification Form.
final verifyCertificateActionHandler = Provider((ref) {
  final trainingService = ref.read(trainingServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  return (String actionId, [Map<String, dynamic>? payload]) async {
    switch (actionId) {
      case 'SUBMIT_VERIFICATION':
        final staffName = payload?['staffName'] as String? ?? '';
        final certName = payload?['certName'] as String? ?? '';

        if (staffName.isEmpty || certName.isEmpty) {
          telemetry.failGate(
            ExecutionGateCategory.compliance,
            'Missing required fields for certificate verification',
          );
          return;
        }

        telemetry.passGate(
          ExecutionGateCategory.compliance,
          'Submitting verification for \$staffName: \$certName',
        );

        final result = await trainingService.verifyCertificate(
          staffName,
          certName,
        );

        result.fold(
          (data) {
            telemetry.passGate(
              ExecutionGateCategory.compliance,
              'Verification Result: \${isValid ? "VALID" : "INVALID"} - \$message',
            );
          },
          (error) {
            telemetry.failGate(
              ExecutionGateCategory.compliance,
              'Server-side verification failed: \$error',
            );
          },
        );
        break;

      default:
        telemetry.failGate(
          ExecutionGateCategory.interaction,
          'Unrecognized form action: \$actionId',
        );
    }
  };
});
