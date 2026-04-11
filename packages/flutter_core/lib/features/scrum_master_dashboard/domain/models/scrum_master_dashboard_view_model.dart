class ScrumMasterDashboardViewModel {
  final List<ScrumMasterKpi> kpis;

  const ScrumMasterDashboardViewModel({this.kpis = const []});
}

class ScrumMasterKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const ScrumMasterKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
