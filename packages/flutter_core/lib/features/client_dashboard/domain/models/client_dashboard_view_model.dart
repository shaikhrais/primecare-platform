import '../../../../config/offline_fallback_state.dart';
class ClientDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<ClientDashboardKpi> kpis;
  final List<ClientDashboardActivity> recentActivity;

  const ClientDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class ClientDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const ClientDashboardKpi({this.title, this.value, this.trend, this.status});
}

class ClientDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const ClientDashboardActivity({this.title, this.subtitle, this.timestamp});
}
