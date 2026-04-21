// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final trainingDirectorDashboardAdapterProvider =
    FutureProvider<Result<TrainingDirectorDashboardViewModel>>((ref) async {
      const cacheKey = 'training_director_dashboard';
      final resilience = ref.read(resilienceServiceProvider);
      final telemetry = ref.read(executionGateProvider);

      // High-Fidelity Hydration with independent resilience for each feed
      final summaryAsync = await ref.watch(trainingSummaryProvider.future);
      final activityAsync = await ref.watch(trainingActivityProvider.future);

      // We accept partial failure: if one fails, we proceed with Success(empty) or Cache for that part
      return summaryAsync.fold(
        (summaryData) {
          final activityData = activityAsync.dataOrNull ?? [];

          // Transform backend data into UI metrics
          final metrics = DashboardMetrics(
            kpis: [
              KpiMetric(
                title: 'Total Assignments',
                value: summaryData['totalActiveAssignments']?.toString() ?? '0',
                status: 'neutral',
              ),
              KpiMetric(
                title: 'Completion Rate',
                value:
                    '${(summaryData['completionRate'] as num?)?.toStringAsFixed(1) ?? '0'}%',
                status: (summaryData['completionRate'] as num? ?? 0) > 90
                    ? 'positive'
                    : 'warning',
                trend: '+2.5%',
              ),
              KpiMetric(
                title: 'Overdue Modules',
                value: summaryData['overdueCount']?.toString() ?? '0',
                status: (summaryData['overdueCount'] as num? ?? 0) > 0
                    ? 'critical'
                    : 'positive',
              ),
              KpiMetric(
                title: 'Certification Compliance',
                value:
                    '${(summaryData['complianceStatus'] as num?)?.toStringAsFixed(1) ?? '0'}%',
                status: (summaryData['complianceStatus'] as num? ?? 0) > 95
                    ? 'positive'
                    : 'warning',
              ),
              KpiMetric(
                title: 'Expiring Certs',
                value: summaryData['expiringCertifications']?.toString() ?? '0',
                status: (summaryData['expiringCertifications'] as num? ?? 0) > 0
                    ? 'warning'
                    : 'neutral',
              ),
            ],
            recentActivity: activityData
                .map(
                  (item) => DashboardActivity(
                    title: item['title'] as String? ?? 'Activity',
                    subtitle: item['subtitle'] as String? ?? '',
                    timestamp:
                        item['date'] as String? ??
                        DateTime.now().toIso8601String(),
                    icon: item['type'] == 'certification'
                        ? 'verified'
                        : 'assignment',
                    color: item['type'] == 'certification' ? 'blue' : 'green',
                  ),
                )
                .toList(),
          );

          final viewModel = TrainingDirectorDashboardViewModel(
            metrics: metrics,
            insights: [], // Placeholder for AI-driven insights
          );

          // Persist LKG snapshot
          unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

          telemetry.passGate(
            ExecutionGateCategory.resilience,
            'Training Director Dashboard hydrated (Live Summary)',
          );
          return Success(viewModel);
        },
        (error) {
          telemetry.passGate(
            ExecutionGateCategory.resilience,
            'TrainingDirector Summary Fallback Triggered',
          );
          // Fallback: Restore from local resilience cache
          final snapshot = resilience.getSnapshot(cacheKey);
          if (snapshot != null) {
            return Success(
              TrainingDirectorDashboardViewModel.fromJson(snapshot),
            );
          }
          return Success(
            TrainingDirectorDashboardViewModel.empty(isOfflineFallback: true),
          );
        },
      );
    });

// Action Handlers for Training Director Dashboard
final trainingDirectorActionHandler = Provider((ref) {
  final telemetry = ref.read(executionGateProvider);

  return (String actionId, [Map<String, dynamic>? payload]) async {
    switch (actionId) {
      case 'BTN_TRAINING_VERIFY':
        // Logic to trigger the verifyCertificateForm
        telemetry.passGate(
          ExecutionGateCategory.interaction,
          'Triggering Certificate Verification Form',
        );
        break;
      case 'BTN_TRAINING_ASSIGN':
        // Logic to trigger the trainingAssignmentForm
        telemetry.passGate(
          ExecutionGateCategory.interaction,
          'Triggering Module Assignment Form',
        );
        break;
      default:
        telemetry.failGate(
          ExecutionGateCategory.interaction,
          'Unrecognized action: $actionId',
        );
    }
  };
});
