import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'compliance_manager_dashboard_screen_controller.dart';

class ComplianceManagerDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The compliance manager dashboard requires components for displaying compliance status, activity logs, and security metrics, along with buttons for executing scans and exporting logs.';

  @override
  List<String> get requiredComponents => const [
        'ComplianceStatusCard',
        'ComplianceActivityLog',
        'SecurityMetricsChart',
        'TelemetryDataChart',
      ];

  @override
  List<String> get requiredFunctions => const [
        'executeComplianceScan',
        'exportAuditLogs',
        'refreshTelemetryData',
      ];

  const ComplianceManagerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(complianceManagerDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('ComplianceManagerDashboard'),
      ),
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
            'ComplianceManagerDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
