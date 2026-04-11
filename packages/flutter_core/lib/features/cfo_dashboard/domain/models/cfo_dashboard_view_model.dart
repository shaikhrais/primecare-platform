class CfoDashboardViewModel {
  final List<CfoKpi> kpis;

  const CfoDashboardViewModel({this.kpis = const []});
}

class CfoKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const CfoKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
