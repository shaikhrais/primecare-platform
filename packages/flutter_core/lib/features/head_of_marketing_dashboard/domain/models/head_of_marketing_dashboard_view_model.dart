import '../../../../config/offline_fallback_state.dart';
class HeadOfMarketingDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<HeadOfMarketingDashboardKpi> kpis;
  final List<HeadOfMarketingDashboardActivity> recentActivity;

  const HeadOfMarketingDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class HeadOfMarketingDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const HeadOfMarketingDashboardKpi({this.title, this.value, this.trend, this.status});
}

class HeadOfMarketingDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const HeadOfMarketingDashboardActivity({this.title, this.subtitle, this.timestamp});
}
