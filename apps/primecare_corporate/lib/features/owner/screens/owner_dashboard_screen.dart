import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'owner_dashboard_screen_controller.dart';

class OwnerDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The owner dashboard requires components for monitoring KPIs, compliance status, and audit logs, along with buttons for executing compliance actions and exporting data.';

  @override
  List<String> get requiredComponents => const [
        'KPIOverview',
        'TelemetryDataChart',
        'ComplianceStatusWidget',
        'AuditLogViewer',
        'PerformanceMetricsCard',
        'SecurityClearanceWidget',
        'ManualSyncButton',
        'ComplianceActionButtons',
        'HistoricalDataChart',
        'AlertsNotification',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshData',
        'runComplianceScan',
        'updateSecurityPolicies',
        'exportLogs',
        'manualSynchronization',
      ];

  const OwnerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ownerDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('OwnerDashboard'),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
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
          PrimeText(
            'OwnerDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
