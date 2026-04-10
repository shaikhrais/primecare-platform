class FranchiseOwnerViewModel {
  final List<FranchiseKpi> kpis;
  final List<FranchiseActivityLog> recentActivity;

  const FranchiseOwnerViewModel({
    this.kpis = const [],
    this.recentActivity = const [],
  });
}

class FranchiseKpi {
  final String label;
  final String value;
  final String? trend;
  const FranchiseKpi({required this.label, required this.value, this.trend});
}

class FranchiseActivityLog {
  final String title;
  final DateTime timestamp;
  const FranchiseActivityLog({required this.title, required this.timestamp});
}
