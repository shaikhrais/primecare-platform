import '../../../../config/offline_fallback_state.dart';
class OperationsManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<OperationsManagerDashboardKpi> kpis;
  final List<OperationsManagerDashboardActivity> recentActivity;

  const OperationsManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}


class OperationsManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;

  const OperationsManagerDashboardActivity({
    this.title,
    this.subtitle,
    this.timestamp,
  });
}


class OperationsManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;

  const OperationsManagerDashboardKpi({
    this.title,
    this.value,
    this.trend,
    this.status,
  });
}
