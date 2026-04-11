class RegionalManagerUsaDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<RegionalUsaKpi> kpis;

  const RegionalManagerUsaDashboardViewModel({required this.kpis, this.recentActivity = const []});
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
