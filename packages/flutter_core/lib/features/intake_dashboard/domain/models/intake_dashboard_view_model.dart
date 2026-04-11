class IntakeDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<IntakeKpi> kpis;

  const IntakeDashboardViewModel({this.kpis = const [], this.recentActivity = const []});
}

class IntakeKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const IntakeKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
