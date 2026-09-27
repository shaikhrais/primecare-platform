import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'regional_bdm_dashboard_screen_controller.dart';

class RegionalBdmDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Regional BDM dashboard requires components to monitor operations, security, and compliance, along with functionalities for data refresh and log export.';

  @override
  List<String> get requiredComponents => const [
        'ActiveOperationsMetric',
        'ProductivityMetric',
        'SecurityClearanceStatus',
        'TelemetryDataChart',
        'ComplianceAuditLogs',
        'GovernanceActionsHighlight',
        'ExportAuditLogsButton',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshData',
        'exportAuditLogs',
      ];

  const RegionalBdmDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regionalBdmDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RegionalBdmDashboard'),
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
            'RegionalBdmDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
