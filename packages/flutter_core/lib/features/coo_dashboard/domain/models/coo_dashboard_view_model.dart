class CooDashboardViewModel {
  final List<dynamic> recentActivity;
  final List<CooKpi> kpis;
  final List<CooFunnelStep> funnelSteps;
  final List<CooGanttTask> ganttTasks;
  final double complianceTargetValue;

  const CooDashboardViewModel({
    this.kpis = const [],
    this.funnelSteps = const [],
    this.ganttTasks = const [],
    this.complianceTargetValue = 0,
   this.recentActivity = const [],});
}

class CooFunnelStep {
  final String label;
  final int count;
  const CooFunnelStep({required this.label, required this.count});
}

class CooGanttTask {
  final String id;
  final String name;
  final DateTime startTime;
  final DateTime endTime;
  const CooGanttTask({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });
}

class CooKpi {
  final String title;
  final String value;
  final String trend;
  final String status;

  const CooKpi({
    required this.title,
    required this.value,
    required this.trend,
    required this.status,
  });
}
