import '../../../../config/offline_fallback_state.dart';
class BillingAdminDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<BillingAdminDashboardKpi> kpis;
  final List<BillingAdminDashboardActivity> recentActivity;

  const BillingAdminDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class BillingAdminDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const BillingAdminDashboardKpi({this.title, this.value, this.trend, this.status});
}

class BillingAdminDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const BillingAdminDashboardActivity({this.title, this.subtitle, this.timestamp});
}
