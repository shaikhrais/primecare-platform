
class COODashboardModel {
  final List<KpiData> kpis;

  COODashboardModel({required this.kpis});
}

class KpiData {
  final String title;
  final String value;
  final String? subtitle;

  KpiData({required this.title, required this.value, this.subtitle});
}
