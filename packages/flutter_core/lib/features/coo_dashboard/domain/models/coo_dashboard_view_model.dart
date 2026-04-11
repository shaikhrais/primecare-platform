class CooDashboardViewModel {
  final List<CooKpi> kpis;

  const CooDashboardViewModel({this.kpis = const []});
}

class CooKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const CooKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
