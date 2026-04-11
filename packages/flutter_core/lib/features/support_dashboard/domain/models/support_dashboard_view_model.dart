class SupportDashboardViewModel {
  final List<SupportKpi> kpis;

  const SupportDashboardViewModel({this.kpis = const []});
}

class SupportKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const SupportKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
