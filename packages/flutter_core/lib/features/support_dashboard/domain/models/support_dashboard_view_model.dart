import '../../../../config/offline_fallback_state.dart';
class SupportDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<SupportKpi> kpis;

  const SupportDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class SupportKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const SupportKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class SupportDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const SupportDashboardKpi({this.title, this.value, this.trend, this.status});
}

class SupportDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const SupportDashboardActivity({this.title, this.subtitle, this.timestamp});
}
