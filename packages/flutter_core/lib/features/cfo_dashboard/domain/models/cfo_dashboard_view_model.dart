class CfoDashboardViewModel {
  final List<CfoKpi> kpis;
  final List<double> revenueData;
  final List<String> revenueLabels;
  final List<double> expenseData;
  final List<String> expenseLabels;
  final double ebitdaTargetValue;
  final double ebitdaTargetMax;

  const CfoDashboardViewModel({
    this.kpis = const [],
    this.revenueData = const [],
    this.revenueLabels = const [],
    this.expenseData = const [],
    this.expenseLabels = const [],
    this.ebitdaTargetValue = 0,
    this.ebitdaTargetMax = 0,
  });
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
