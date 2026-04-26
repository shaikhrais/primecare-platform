import 'package:easy_localization/easy_localization.dart';
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final qualityAssuranceDashboardAdapterProvider =
    FutureProvider<Result<QualityAssuranceDashboardViewModel>>((ref) async {
      const route = 'QualityAssurance';
      const cacheKey = 'qa_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      try {
        final result = await ref.watch(dashboardMetricsProvider(route).future);

        return result.fold((metrics) {
          final viewModel = QualityAssuranceDashboardViewModel(
            metrics: metrics,
            insights: _getSmartQaMocks(),
            isOfflineFallback: false,
          );

          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

          telemetry.passGate(
            ExecutionGateCategory.intelligence,
            'QA Compliance Intelligence Mapping Successful',
          );

          return Success(viewModel);
        }, (error) => _handleQaFallback(resilience, cacheKey, telemetry));
      } catch (e) {
        return _handleQaFallback(resilience, cacheKey, telemetry);
      }
    });

Result<QualityAssuranceDashboardViewModel> _handleQaFallback(
  ResilienceService resilience,
  String cacheKey,
  ExecutionGateService telemetry,
) {
  final snapshot = resilience.getSnapshot(cacheKey);
  if (snapshot != null) {
    try {
      final vm = QualityAssuranceDashboardViewModel.fromJson(snapshot);
      return Success(
        QualityAssuranceDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ),
      );
    } catch (e) {
      // Handled by empty state
    }
  }

  return Success(
    QualityAssuranceDashboardViewModel.empty(isOfflineFallback: true),
  );
}

List<IntelligenceInsight> _getSmartQaMocks() {
  return [
    IntelligenceInsight(
      id: 'qa_01',
      title: LocaleKeys
          .dashboards_qualityassurance_labels_compliance_drift_detected
          .tr(),
      summary:
          'Documentation completion rates in Section B have dropped below 90% threshold.',
      impact: InsightImpact.warning,
      type: InsightType.alert,
      recommendation:
          'Initiate targeted training for clinical staff on the updated Section B protocols.',
    ),
    IntelligenceInsight(
      id: 'qa_02',
      title: LocaleKeys.dashboards_qualityassurance_labels_audit_readiness_high
          .tr(),
      summary:
          'Accreditation prep score has reached 98% based on recent internal simulation.',
      impact: InsightImpact.positive,
      type: InsightType.standard,
      recommendation:
          'Finalize the executive summary for the upcoming site visit.',
    ),
  ];
}
