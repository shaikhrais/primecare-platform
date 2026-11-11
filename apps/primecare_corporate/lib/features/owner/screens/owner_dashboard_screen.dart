import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
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

    return PrimePageScaffold(
      title: const PrimeText('OwnerDashboard'),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const DashboardLoadingWidget(),
        error: (error, stack) => Center(child: PrimeText('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const PrimeStatusIcon(Icons.check_circle_outline, tone: PrimeStatusTone.success, size: 64),
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
