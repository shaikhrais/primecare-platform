import 'package:flutter/material.dart';
import 'package:primecare_ui/src/shared/primecare_adapters.dart';

// 1. The Data Provider (Simulates API Backend)
final telemetryProvider = FutureProvider.family<Map<String, String>, UserRole>((ref, role) async {
  // Simulate network delay
  await Future.delayed(const Duration(milliseconds: 800));
  
  // Return mocked real-time data based on role
  if (role == UserRole.ceo) {
    return {
      'strategic_growth': '+15% YoY (Trend: Up)',
      'revenue_growth': '\$2.4M (This Quarter)',
      'operational_efficiency': '94% (Target: 95%)',
      'market_expansion': '3 Active Regions (NA, EU, APAC)',
    };
  } else if (role == UserRole.cto) {
    return {
      'global_uptime': '99.999% (All systems healthy)',
      'api_latency': '42ms (Avg over 24h)',
      'error_rate': '0.01% (Within SLA)',
      'security_posture': 'Critical Alert: Zero-Day patched',
      'devops_velocity': '12 Deploys/Day',
    };
  }
  
  // Fallback generic data
  return {
    'system_health': 'All Systems Operational',
    'active_users': '1,204 Online',
  };
});

class DynamicDashboard extends ConsumerWidget {
  final UserRole role;

  const DynamicDashboard({super.key, required this.role});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2. Fetch structural config directly from our Dart registry
    final widgetsConfig = DashboardRegistry.inventory[role] ?? [];
    
    // 3. Watch the telemetry data provider to hydrate the structure
    final telemetryAsync = ref.watch(telemetryProvider(role));

    return Scaffold(
      appBar: AppBar(title: Text('${role.name.toUpperCase()} Dashboard')),
      body: widgetsConfig.isEmpty 
          ? const Center(child: Text('No widgets configured for this role.'))
          : telemetryAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error loading data: $err')),
              data: (telemetryData) {
                return ListView.builder(
                  itemCount: widgetsConfig.length,
                  itemBuilder: (context, index) {
                    final config = widgetsConfig[index];
                    // Map the structural ID to the API data
                    final widgetData = telemetryData[config.id] ?? 'Data processing...';
                    return _buildWidgetRenderer(config, widgetData);
                  },
                );
              },
            ),
    );
  }

  // 4. Render UI based on the exact type directly
  Widget _buildWidgetRenderer(DashboardWidgetConfig config, String data) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(_getIconForType(config.type), color: Colors.blue.shade800),
        ),
        title: Text(config.label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(data, style: const TextStyle(fontSize: 18, color: Colors.blueGrey)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
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
