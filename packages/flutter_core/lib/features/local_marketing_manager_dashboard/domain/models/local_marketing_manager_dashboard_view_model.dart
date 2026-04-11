import '../../../../config/offline_fallback_state.dart';
class LocalMarketingManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<LocalMarketingManagerDashboardKpi> kpis;
  final List<LocalMarketingManagerDashboardActivity> recentActivity;

  const LocalMarketingManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class LocalMarketingManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const LocalMarketingManagerDashboardKpi({this.title, this.value, this.trend, this.status});
}

class LocalMarketingManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const LocalMarketingManagerDashboardActivity({this.title, this.subtitle, this.timestamp});
}
