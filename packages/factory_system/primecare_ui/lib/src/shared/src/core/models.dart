enum WidgetType { chart, metricCard, dataTable, list }

class DashboardWidgetConfig {
  final String id;
  final String label;
  final WidgetType type;

  const DashboardWidgetConfig({
    required this.id,
    required this.label,
    required this.type,
  });
}
