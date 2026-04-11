import '../../../../config/offline_fallback_state.dart';
class PartnershipManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<PartnershipManagerDashboardKpi> kpis;
  final List<PartnershipManagerDashboardActivity> recentActivity;

  const PartnershipManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class PartnershipManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const PartnershipManagerDashboardKpi({this.title, this.value, this.trend, this.status});
}

class PartnershipManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const PartnershipManagerDashboardActivity({this.title, this.subtitle, this.timestamp});
}
