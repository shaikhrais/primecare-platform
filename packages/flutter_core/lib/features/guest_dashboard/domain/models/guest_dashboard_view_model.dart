import '../../../../config/offline_fallback_state.dart';
class GuestDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<GuestKpi> kpis;

  const GuestDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class GuestKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const GuestKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class GuestDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const GuestDashboardKpi({this.title, this.value, this.trend, this.status});
}

class GuestDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const GuestDashboardActivity({this.title, this.subtitle, this.timestamp});
}
