
class CFODashboardModel {
  final List<KpiData> kpis;
  final List<FinancialData> revenueTrend;

  CFODashboardModel({
    required this.kpis,
    this.revenueTrend = const [],
  });
}

class KpiData {
  final String title;
  final String value;
  final String? subtitle;

  KpiData({required this.title, required this.value, this.subtitle});
}

class FinancialData {
  final DateTime date;
  final double value;

  FinancialData(this.date, this.value);
}
