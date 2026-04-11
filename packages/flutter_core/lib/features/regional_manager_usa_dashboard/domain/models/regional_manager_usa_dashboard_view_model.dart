import '../../../../config/offline_fallback_state.dart';
class RegionalManagerUsaDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<dynamic> recentActivity;
  final List<RegionalUsaKpi> kpis;

  const RegionalManagerUsaDashboardViewModel({
    this.isOfflineFallback = false,required this.kpis, this.recentActivity = const []});
}

class RegionalUsaKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const RegionalUsaKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class RegionalManagerUsaDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const RegionalManagerUsaDashboardKpi({this.title, this.value, this.trend, this.status});
}

class RegionalManagerUsaDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const RegionalManagerUsaDashboardActivity({this.title, this.subtitle, this.timestamp});
}
