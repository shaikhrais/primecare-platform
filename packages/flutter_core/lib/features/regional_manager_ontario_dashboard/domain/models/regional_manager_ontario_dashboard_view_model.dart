import '../../../../config/offline_fallback_state.dart';
class RegionalManagerOntarioDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<RegionalOntarioKpi> kpis;

  const RegionalManagerOntarioDashboardViewModel({
    this.isOfflineFallback = false,required this.kpis, this.recentActivity = const []});
}

class RegionalOntarioKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const RegionalOntarioKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class RegionalManagerOntarioDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const RegionalManagerOntarioDashboardKpi({this.title, this.value, this.trend, this.status});
}

class RegionalManagerOntarioDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const RegionalManagerOntarioDashboardActivity({this.title, this.subtitle, this.timestamp});
}
