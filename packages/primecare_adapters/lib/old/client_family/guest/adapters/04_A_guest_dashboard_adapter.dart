import 'package:easy_localization/easy_localization.dart';
// Layer: 04_UI_ADAPTERS
import 'dart:async';
import 'package:primecare_adapters/primecare_adapters.dart';

final guestDashboardAdapterProvider = FutureProvider<Result<GuestDashboardViewModel>>((
  ref,
) async {
  const route = 'Guest';
  const cacheKey = 'guest_dashboard';
  final resilience = ref.read(resilienceServiceProvider);
  final telemetry = ref.read(executionGateProvider);

  // Watch the hardened infrastructure provider for standardized metrics fetching
  final result = await ref.watch(dashboardMetricsProvider(route).future);

  return result.fold(
    (metrics) {
      // Inject High-Fidelity Guest Charts
      final charts = [
        AnalyticsChart(
          id: 'visit-frequency',
          title: LocaleKeys.dashboards_guest_labels_your_visits__monthly.tr(),
          type: ChartType.line,
          dataPoints: [
            ChartDataPoint(label: 'Jan', value: 2),
            ChartDataPoint(label: 'Feb', value: 4),
            ChartDataPoint(label: 'Mar', value: 3),
            ChartDataPoint(label: 'Apr', value: 5),
          ],
        ),
      ];

      // Inject Recent Guest Activities
      final activities = [
        DashboardActivity(
          title: LocaleKeys.dashboards_guest_labels_check_in_success.tr(),
          subtitle: LocaleKeys
              .dashboards_guest_labels_main_lobby___guest_id__4421
              .tr(),
          timestamp: 'Just now',
          icon: 'login',
          color: 'green',
        ),
        DashboardActivity(
          title: LocaleKeys.dashboards_guest_labels_feedback_submitted.tr(),
          subtitle: LocaleKeys
              .dashboards_guest_labels_q1_dining_experience_survey
              .tr(),
          timestamp: '2d ago',
          icon: 'rate_review',
          color: 'blue',
        ),
      ];

      final activeMetrics = metrics.copyWith(
        charts: charts,
        recentActivity: activities,
      );

      final viewModel = GuestDashboardViewModel(
        metrics: activeMetrics,
        insights: [
          IntelligenceInsight(
            id: 'guest_1',
            title: LocaleKeys
                .dashboards_guest_labels_personalized_recommendation
                .tr(),
            summary:
                'We noticed you enjoy afternoon walks. Check out the new South Path.',
            type: InsightType.standard,
            impact: InsightImpact.positive,
            recommendation:
                'Join the "Garden Walk" group on Wednesdays at 3PM.',
            category: 'Wellness',
          ),
          IntelligenceInsight(
            id: 'guest_2',
            title: LocaleKeys.dashboards_guest_labels_dining_update.tr(),
            summary:
                'The Bistro is featuring a Seasonal Harvest menu this weekend.',
            type: InsightType.standard,
            impact: InsightImpact.standard,
            recommendation:
                'Reserve a table via the "Dining" tab for Saturday dinner.',
            category: 'Services',
          ),
        ],
      );

      // Persist LKG snapshot for offline survival
      unawaited(resilience.saveSnapshot(cacheKey, viewModel.toJson()));

      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Guest Dashboard route hydrated',
      );
      return Success(viewModel);
    },
    (error) {
      telemetry.passGate(
        ExecutionGateCategory.resilience,
        'Guest Metrics Logistics Fallback Triggered',
      );
      // Fallback: Restore from local resilience cache if infrastructure is unreachable
      final snapshot = resilience.getSnapshot(cacheKey);
      if (snapshot != null) {
        final vm = GuestDashboardViewModel.fromJson(snapshot);
        return Success(
          GuestDashboardViewModel(
            metrics: vm.metrics,
            insights: vm.insights,
            blueprints: vm.blueprints,
            isOfflineFallback: true,
          ),
        );
      }
      return Success(GuestDashboardViewModel.empty(isOfflineFallback: true));
    },
  );
});
