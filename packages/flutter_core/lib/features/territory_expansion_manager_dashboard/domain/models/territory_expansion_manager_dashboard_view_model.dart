import '../../../../config/offline_fallback_state.dart';
class TerritoryExpansionManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<TerritoryExpansionManagerDashboardKpi> kpis;
  final List<TerritoryExpansionManagerDashboardActivity> recentActivity;

  const TerritoryExpansionManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}


class TerritoryExpansionManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;

  const TerritoryExpansionManagerDashboardActivity({
    this.title,
    this.subtitle,
    this.timestamp,
  });
}


class TerritoryExpansionManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;

  const TerritoryExpansionManagerDashboardKpi({
    this.title,
    this.value,
    this.trend,
    this.status,
  });
}
