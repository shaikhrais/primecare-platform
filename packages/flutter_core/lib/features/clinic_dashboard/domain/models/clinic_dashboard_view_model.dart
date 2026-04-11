import '../../../../config/offline_fallback_state.dart';
class ClinicDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<ClinicDashboardKpi> kpis;
  final List<ClinicDashboardActivity> recentActivity;

  const ClinicDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class ClinicDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const ClinicDashboardKpi({this.title, this.value, this.trend, this.status});
}

class ClinicDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const ClinicDashboardActivity({this.title, this.subtitle, this.timestamp});
}
