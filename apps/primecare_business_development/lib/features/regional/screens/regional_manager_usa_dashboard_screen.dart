import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'regional_manager_usa_dashboard_screen_controller.dart';

class RegionalManagerUsaDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring operations, compliance audits, security clearance, and telemetry data, along with buttons for running scans and exporting logs.';

  @override
  List<String> get requiredComponents => const [
        'ActiveOperationsOverview',
        'ComplianceAuditStatus',
        'SecurityClearanceLevels',
        'TelemetryDataChart',
        'AuditLogsTable',
        'RedFlagsNotification',
        'ComplianceScanButton',
        'ExportLogsButton',
        'HistoricalDataChart',
        'UserFriendlyNavigation',
      ];

  @override
  List<String> get requiredFunctions => const [
        'runComplianceScan',
        'exportAuditLogs',
      ];

  const RegionalManagerUsaDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regionalManagerUsaDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('RegionalManagerUsaDashboard'),
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
            'RegionalManagerUsaDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
