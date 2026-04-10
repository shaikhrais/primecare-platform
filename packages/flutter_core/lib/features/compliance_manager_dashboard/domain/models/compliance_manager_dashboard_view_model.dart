class ComplianceManagerDashboardViewModel {
  final List<ComplianceKpi> kpis;
  final List<ComplianceActivity> recentActivity;

  const ComplianceManagerDashboardViewModel({
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
