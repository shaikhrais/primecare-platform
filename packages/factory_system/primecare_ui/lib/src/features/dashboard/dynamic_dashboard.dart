import 'package:flutter/material.dart';
import 'package:primecare_adapters/primecare_adapters.dart';

class DynamicDashboard extends StatelessWidget {
  final UserRole role;

  const DynamicDashboard({Key? key, required this.role}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 1. Fetch config directly from our Dart registry, instantly resolving
    final widgetsConfig = DashboardRegistry.inventory[role] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('${role.name.toUpperCase()} Dashboard')),
      body: widgetsConfig.isEmpty 
          ? const Center(child: Text('No widgets configured for this role.'))
          : ListView.builder(
              itemCount: widgetsConfig.length,
              itemBuilder: (context, index) {
                final config = widgetsConfig[index];
                return _buildWidgetRenderer(config);
              },
            ),
    );
  }

  // 2. Render UI based on the exact type directly
  Widget _buildWidgetRenderer(DashboardWidgetConfig config) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(_getIconForType(config.type)),
        ),
        title: Text(config.label, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('Widget ID: ${config.id}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      ),
    );
  }

  IconData _getIconForType(WidgetType type) {
    switch (type) {
      case WidgetType.chart:
        return Icons.bar_chart;
      case WidgetType.metricCard:
        return Icons.numbers;
      case WidgetType.dataTable:
        return Icons.table_chart;
      case WidgetType.list:
        return Icons.list;
    }
  }
}
