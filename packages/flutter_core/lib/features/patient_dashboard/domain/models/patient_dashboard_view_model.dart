class PatientDashboardViewModel {
  final List<PatientKpi> kpis;

  const PatientDashboardViewModel({this.kpis = const []});
}

class PatientKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const PatientKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
