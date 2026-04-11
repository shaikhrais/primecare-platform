import '../../../../config/offline_fallback_state.dart';
class FranchiseOwnerViewModel implements OfflineFallbackState {
  @override
  final bool isOfflineFallback;
  final List<FranchiseKpi> kpis;
  final List<FranchiseActivityLog> recentActivity;

  const FranchiseOwnerViewModel({
    this.isOfflineFallback = false,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class FranchiseKpi {
  final String title;
  final String status;
  final String value;
  final String? trend;
  const FranchiseKpi({required this.title, required this.value, this.trend, required this.status});
}

class FranchiseActivityLog {
  final String title;
  final DateTime timestamp;
  const FranchiseActivityLog({required this.title, required this.timestamp});
}

class FranchiseOwnerKpi {
  final String? title;
  final String? value;
  final String? trend;
  final String? status;
  const FranchiseOwnerKpi({this.title, this.value, this.trend, this.status});
}

class FranchiseOwnerActivity {
  final String? title;
  final String? subtitle;
  final String? timestamp;
  const FranchiseOwnerActivity({this.title, this.subtitle, this.timestamp});
}
