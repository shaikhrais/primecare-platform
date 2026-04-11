import '../../../../config/offline_fallback_state.dart';
class CustomerSupportDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<CustomerSupportDashboardKpi> kpis;
  final List<CustomerSupportDashboardActivity> recentActivity;

  const CustomerSupportDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class CustomerSupportDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const CustomerSupportDashboardKpi({this.title, this.value, this.trend, this.status});
}

class CustomerSupportDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const CustomerSupportDashboardActivity({this.title, this.subtitle, this.timestamp});
}
