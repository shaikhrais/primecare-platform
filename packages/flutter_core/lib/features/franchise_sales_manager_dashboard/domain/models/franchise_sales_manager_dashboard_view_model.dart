import '../../../../config/offline_fallback_state.dart';
class FranchiseSalesManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<FranchiseSalesManagerDashboardKpi> kpis;
  final List<FranchiseSalesManagerDashboardActivity> recentActivity;

  const FranchiseSalesManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}


class FranchiseSalesManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;

  const FranchiseSalesManagerDashboardActivity({
    this.title,
    this.subtitle,
    this.timestamp,
  });
}


class FranchiseSalesManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;

  const FranchiseSalesManagerDashboardKpi({
    this.title,
    this.value,
    this.trend,
    this.status,
  });
}
