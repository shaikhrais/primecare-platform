import '../../../../config/offline_fallback_state.dart';
class CtoDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<CtoKpi> kpis;

  const CtoDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class CtoKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const CtoKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class CtoDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const CtoDashboardKpi({this.title, this.value, this.trend, this.status});
}

class CtoDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const CtoDashboardActivity({this.title, this.subtitle, this.timestamp});
}
