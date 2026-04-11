import '../../../../config/offline_fallback_state.dart';
class ScrumMasterDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<ScrumMasterKpi> kpis;

  const ScrumMasterDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class ScrumMasterKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const ScrumMasterKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class ScrumMasterDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const ScrumMasterDashboardKpi({this.title, this.value, this.trend, this.status});
}

class ScrumMasterDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const ScrumMasterDashboardActivity({this.title, this.subtitle, this.timestamp});
}
