class RegionalManagerOntarioDashboardViewModel {
  final List<RegionalOntarioKpi> kpis;

  const RegionalManagerOntarioDashboardViewModel({required this.kpis});
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
