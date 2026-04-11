class QaDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<QaKpi> kpis;

  const QaDashboardViewModel({this.kpis = const [], this.recentActivity = const []});
}

class QaKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const QaKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
