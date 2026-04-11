import '../../../../config/offline_fallback_state.dart';
class FamilyDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<FamilyDashboardKpi> kpis;
  final List<FamilyDashboardActivity> recentActivity;

  const FamilyDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class FamilyDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const FamilyDashboardKpi({this.title, this.value, this.trend, this.status});
}

class FamilyDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const FamilyDashboardActivity({this.title, this.subtitle, this.timestamp});
}
