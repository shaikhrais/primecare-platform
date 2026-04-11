import '../../../../config/offline_fallback_state.dart';
class QaDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<QaKpi> kpis;

  const QaDashboardViewModel({
    this.isOfflineFallback = false,this.kpis = const [], this.recentActivity = const []});
}

class QaKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const QaKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class QaDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const QaDashboardKpi({this.title, this.value, this.trend, this.status});
}

class QaDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const QaDashboardActivity({this.title, this.subtitle, this.timestamp});
}
