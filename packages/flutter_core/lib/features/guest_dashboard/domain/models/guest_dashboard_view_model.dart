class GuestDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<GuestKpi> kpis;

  const GuestDashboardViewModel({this.kpis = const [], this.recentActivity = const []});
}

class GuestKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const GuestKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
