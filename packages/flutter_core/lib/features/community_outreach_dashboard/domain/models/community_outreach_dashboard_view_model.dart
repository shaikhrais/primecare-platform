import '../../../../config/offline_fallback_state.dart';
class CommunityOutreachDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<CommunityOutreachDashboardKpi> kpis;
  final List<CommunityOutreachDashboardActivity> recentActivity;

  const CommunityOutreachDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class CommunityOutreachDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const CommunityOutreachDashboardKpi({this.title, this.value, this.trend, this.status});
}

class CommunityOutreachDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const CommunityOutreachDashboardActivity({this.title, this.subtitle, this.timestamp});
}
