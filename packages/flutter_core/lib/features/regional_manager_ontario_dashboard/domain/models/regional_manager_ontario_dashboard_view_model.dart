class RegionalManagerOntarioDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<RegionalOntarioKpi> kpis;

  const RegionalManagerOntarioDashboardViewModel({required this.kpis, this.recentActivity = const []});
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
