class TrainingCoordinatorDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<TrainingCoordinatorKpi> kpis;

  const TrainingCoordinatorDashboardViewModel({this.kpis = const [], this.recentActivity = const []});
}

class TrainingCoordinatorKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const TrainingCoordinatorKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
