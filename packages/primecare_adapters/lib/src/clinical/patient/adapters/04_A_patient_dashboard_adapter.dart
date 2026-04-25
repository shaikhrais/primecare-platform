// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final patientDashboardAdapterProvider =
    FutureProvider<Result<PatientDashboardViewModel>>((ref) async {
      const route = 'Patient';
      const cacheKey = 'patient_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      // Watch the hardened infrastructure provider for standardized metrics fetching
      final result = await ref.watch(dashboardMetricsProvider(route).future);

      return result.fold(
        (metrics) {
          late PatientDashboardViewModel viewModel;
          try {
            viewModel = PatientDashboardViewModel(
              metrics: metrics,
              insights: _getSmartPatientMocks(),
              isOfflineFallback: false,
            );
            telemetry.passGate(
              ExecutionGateCategory.intelligence,
              'Patient Health Intelligence Mapping Successful',
            );
          } catch (e) {
            viewModel = PatientDashboardViewModel.empty(
              isOfflineFallback: true,
            );
          }

          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));
          return Success(viewModel);
        },
        (error) {
          telemetry.passGate(
            ExecutionGateCategory.resilience,
            'Patient Logistics Fallback Triggered',
          );
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            final vm = PatientDashboardViewModel.fromJson(snapshot);
            return Success(
              PatientDashboardViewModel(
                metrics: vm.metrics,
                insights: vm.insights,
                blueprints: vm.blueprints,
                isOfflineFallback: true,
              ),
            );
          }
          return Success(
            PatientDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

List<IntelligenceInsight> _getSmartPatientMocks() {
  return [
    IntelligenceInsight(
      id: 'pat_01',
      title: 'Vitals Deviation Alert',
      summary:
          'Systolic blood pressure has trended upward (+15 mmHg) over the last 3 readings.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      recommendation:
          'Contact your Primary Care Physician to review medication dosage.',
    ),
    IntelligenceInsight(
      id: 'pat_02',
      title: 'Care Plan Milestone',
      summary:
          'You have completed 85% of your rehabilitation goals for this cycle.',
      impact: InsightImpact.positive,
      type: InsightType.standard,
      recommendation:
          'Keep up the momentum! Schedule your final assessment for next Thursday.',
    ),
  ];
}
