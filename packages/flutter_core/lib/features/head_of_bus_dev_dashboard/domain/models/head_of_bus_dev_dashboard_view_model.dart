import '../../../../config/offline_fallback_state.dart';
class HeadOfBusDevDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<HeadOfBusDevDashboardKpi> kpis;
  final List<HeadOfBusDevDashboardActivity> recentActivity;

  const HeadOfBusDevDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class HeadOfBusDevDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const HeadOfBusDevDashboardKpi({this.title, this.value, this.trend, this.status});
}

class HeadOfBusDevDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const HeadOfBusDevDashboardActivity({this.title, this.subtitle, this.timestamp});
}
