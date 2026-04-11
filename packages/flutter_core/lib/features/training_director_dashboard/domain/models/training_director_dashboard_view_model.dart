class TrainingDirectorDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<TrainingKpi> kpis;

  const TrainingDirectorDashboardViewModel({required this.kpis, this.recentActivity = const []});
}

class TrainingKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const TrainingKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
