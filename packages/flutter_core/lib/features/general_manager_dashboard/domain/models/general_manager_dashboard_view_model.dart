import '../../../../config/offline_fallback_state.dart';
class GeneralManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<GeneralManagerDashboardKpi> kpis;
  final List<GeneralManagerDashboardActivity> recentActivity;

  const GeneralManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class GeneralManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const GeneralManagerDashboardKpi({this.title, this.value, this.trend, this.status});
}

class GeneralManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const GeneralManagerDashboardActivity({this.title, this.subtitle, this.timestamp});
}
