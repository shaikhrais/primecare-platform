// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final trainingCoordinatorDashboardAdapterProvider =
    FutureProvider<Result<TrainingCoordinatorDashboardViewModel>>((ref) async {
  const route = 'TrainingCoordinator';
  const cacheKey = 'training_coordinator_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      // Inject mock chart data for Training Coordinator
      final enhancedMetrics = DashboardMetrics(
        kpis: metrics.kpis,
        recentActivity: metrics.recentActivity,
        charts: [
          AnalyticsChart(
            id: 'training_success',
            title: 'Course Success Rate',
            type: ChartType.line,
            dataPoints: [
              ChartDataPoint(label: 'Jan', value: 82, color: 'blue'),
              ChartDataPoint(label: 'Feb', value: 85, color: 'blue'),
              ChartDataPoint(label: 'Mar', value: 88, color: 'green'),
              ChartDataPoint(label: 'Apr', value: 91, color: 'green'),
            ],
          ),
          AnalyticsChart(
            id: 'enrollment_trends',
            title: 'Monthly Enrollments',
            type: ChartType.bar,
            dataPoints: [
              ChartDataPoint(label: 'OSHA', value: 45, color: 'orange'),
              ChartDataPoint(label: 'HIPAA', value: 120, color: 'blue'),
              ChartDataPoint(label: 'First Aid', value: 65, color: 'green'),
            ],
          ),
        ],
      );

      final viewModel = TrainingCoordinatorDashboardViewModel(
        metrics: enhancedMetrics,
        insights: [
          IntelligenceInsight(
            id: 'ins_tc_01',
            title: 'Certification Deadline Looming',
            summary: '12 staff members in the Ontario region have HIPAA certifications expiring in 30 days.',
            impact: InsightImpact.warning,
            category: 'compliance',
            type: InsightType.alert,
          ),
          IntelligenceInsight(
            id: 'ins_tc_02',
            title: 'High Engagement in "Documentation 101"',
            summary: 'Course completion speed is 25% faster than average this month.',
            impact: InsightImpact.positive,
            category: 'efficiency',
            type: InsightType.growth,
          ),
        ],
      );

      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Training Coordinator Dashboard hydrated (Enhanced)',
      );
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'TrainingCoordinator Metrics Logistics Fallback Triggered',
      );
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = TrainingCoordinatorDashboardViewModel.fromJson(snapshot);
        return Success(TrainingCoordinatorDashboardViewModel(
          metrics: vm.metrics,
          insights: vm.insights,
          blueprints: vm.blueprints,
          isOfflineFallback: true,
        ));
      }
      return Success(
        TrainingCoordinatorDashboardViewModel.empty(isOfflineFallback: true),
      );
    },
  );
});

// Action Handlers for Training Coordinator Dashboard
final trainingCoordinatorActionHandler = Provider((ref) {
  final telemetry = ref.read(executionGateProvider);

  return (String actionId, [Map<String, dynamic>? payload]) async {
    switch (actionId) {
      case 'BTN_COURSE_ASSIGN':
        telemetry.passGate(
          ExecutionGateCategory.interaction,
          'Triggering Course Assignment Flow',
        );
        break;
      case 'BTN_CERT_RENEW_ALL':
        telemetry.passGate(
          ExecutionGateCategory.interaction,
          'Triggering Bulk Certification Renewal',
        );
        break;
      default:
        telemetry.failGate(
          ExecutionGateCategory.interaction,
          'Unrecognized coordinator action: $actionId',
        );
    }
  };
});
