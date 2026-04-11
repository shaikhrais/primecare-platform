import '../../../../config/offline_fallback_state.dart';
class ComplianceManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<ComplianceKpi> kpis;
  final List<ComplianceActivity> recentActivity;

  const ComplianceManagerDashboardViewModel({
    this.isOfflineFallback = false,
    required this.kpis,
    this.recentActivity = const [],
  });
}

class ComplianceKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const ComplianceKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}

class ComplianceActivity {
  final String title;
  final String subtitle;
  final String timestamp;

  const ComplianceActivity({
    required this.title,
    required this.subtitle,
    required this.timestamp,
  });
}

class ComplianceManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const ComplianceManagerDashboardKpi({this.title, this.value, this.trend, this.status});
}

class ComplianceManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const ComplianceManagerDashboardActivity({this.title, this.subtitle, this.timestamp});
}
