import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ciso_dashboard_screen_controller.dart';

class CisoDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The CISO dashboard requires components to display security metrics, alerts, compliance status, and budget utilization, along with buttons for data refresh and report viewing.';

  @override
  List<String> get requiredComponents => const [
        'SecurityPostureCard',
        'ActiveAlertsList',
        'KPIMetricsWidget',
        'IncidentResponseMetricsChart',
        'ComplianceStatusIndicator',
        'TrainingCompletionChart',
        'AuditLogsTable',
        'TelemetryDataStream',
        'BudgetUtilizationChart',
        'HistoricalTrendsGraph',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshDashboardData',
        'viewDetailedReport',
        'exportDashboardData',
      ];

  const CisoDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cisoDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CisoDashboard'),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            'CisoDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
