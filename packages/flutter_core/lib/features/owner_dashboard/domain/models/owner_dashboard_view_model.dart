import '../../../../config/offline_fallback_state.dart';
class OwnerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<OwnerDashboardKpi> kpis;
  final List<OwnerDashboardActivity> recentActivity;

  const OwnerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}


class OwnerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;

  const OwnerDashboardActivity({
    this.title,
    this.subtitle,
    this.timestamp,
  });
}


class OwnerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;

  const OwnerDashboardKpi({
    this.title,
    this.value,
    this.trend,
    this.status,
  });
}
