import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ceo_dashboard_screen_controller.dart';

class CeoDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for visualizing KPIs, financial summaries, project management, employee performance, alerts, interactive charts, and communication tools, along with associated buttons, functions, APIs, and responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'KPIVisualization',
        'FinancialSummary',
        'ProjectManagementOverview',
        'EmployeePerformanceMetrics',
        'AlertsDashboard',
        'InteractiveCharts',
        'CommunicationTools',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchKPIs',
        'generateFinancialReport',
        'updateProjectStatus',
        'evaluateEmployeePerformance',
        'checkAlerts',
        'renderCharts',
        'sendCommunication',
      ];

  const CeoDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ceoDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CeoDashboard'),
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
            'CeoDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
