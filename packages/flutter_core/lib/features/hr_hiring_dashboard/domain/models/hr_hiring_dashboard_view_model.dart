import '../../../../config/offline_fallback_state.dart';
class HrHiringDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<HrHiringDashboardKpi> kpis;
  final List<HrHiringDashboardActivity> recentActivity;

  const HrHiringDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class HrHiringDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const HrHiringDashboardKpi({this.title, this.value, this.trend, this.status});
}

class HrHiringDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const HrHiringDashboardActivity({this.title, this.subtitle, this.timestamp});
}
