
class CTODashboardModel {
  final List<KpiData> kpis;

  CTODashboardModel({required this.kpis});
}

class KpiData {
  final String title;
  final String value;
  final String? subtitle;

  KpiData({required this.title, required this.value, this.subtitle});
}
