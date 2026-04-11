import '../../../../config/offline_fallback_state.dart';
class TerritorySalesManagerDashboardViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<TerritorySalesManagerDashboardKpi> kpis;
  final List<TerritorySalesManagerDashboardActivity> recentActivity;

  const TerritorySalesManagerDashboardViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}


class TerritorySalesManagerDashboardActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;

  const TerritorySalesManagerDashboardActivity({
    this.title,
    this.subtitle,
    this.timestamp,
  });
}


class TerritorySalesManagerDashboardKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;

  const TerritorySalesManagerDashboardKpi({
    this.title,
    this.value,
    this.trend,
    this.status,
  });
}
