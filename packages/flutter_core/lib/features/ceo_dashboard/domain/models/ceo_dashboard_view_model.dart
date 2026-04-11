import '../../../../config/offline_fallback_state.dart';
class CeoDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<CeoKpi> kpis;
  final List<CeoActivity> recentActivity;

  const CeoDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class CeoKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const CeoKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class CeoActivity {
  final String title;
  final String subtitle;
  final String timestamp;

  const CeoActivity({
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });
}

class CeoDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const CeoDashboardKpi({this.title, this.value, this.trend, this.status});
}

class CeoDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const CeoDashboardActivity({this.title, this.subtitle, this.timestamp});
}
