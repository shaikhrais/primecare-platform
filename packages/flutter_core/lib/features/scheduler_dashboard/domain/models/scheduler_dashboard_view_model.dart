import '../../../../config/offline_fallback_state.dart';
class SchedulerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<SchedulerDashboardKpi> kpis;
  final List<SchedulerDashboardActivity> recentActivity;

  const SchedulerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}


class SchedulerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;

  const SchedulerDashboardActivity({
    this.title,
    this.subtitle,
    this.timestamp,
  });
}


class SchedulerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;

  const SchedulerDashboardKpi({
    this.title,
    this.value,
    this.trend,
    this.status,
  });
}
