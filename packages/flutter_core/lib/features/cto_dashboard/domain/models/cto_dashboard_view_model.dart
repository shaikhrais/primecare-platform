class CtoDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<CtoKpi> kpis;

  const CtoDashboardViewModel({this.kpis = const [], this.recentActivity = const []});
}

class CtoKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const CtoKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
