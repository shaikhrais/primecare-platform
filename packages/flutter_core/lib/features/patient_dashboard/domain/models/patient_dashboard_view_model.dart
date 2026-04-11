import '../../../../config/offline_fallback_state.dart';
class PatientDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<PatientKpi> kpis;

  const PatientDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class PatientKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const PatientKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class PatientDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const PatientDashboardKpi({this.title, this.value, this.trend, this.status});
}

class PatientDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const PatientDashboardActivity({this.title, this.subtitle, this.timestamp});
}
