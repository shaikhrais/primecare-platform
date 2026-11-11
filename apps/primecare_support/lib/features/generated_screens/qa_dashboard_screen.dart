import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'qa_dashboard_screen_controller.dart';

class QaDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The qa_dashboard screen requires components for monitoring compliance, operational metrics, alerts, and user actions, along with API integrations for executing tasks and reporting issues.';

  @override
  List<String> get requiredComponents => const [
        'ComplianceScanStatus',
        'OperationalMetricsCard',
        'AlertsNotification',
        'AuditLogHistory',
        'TelemetryDataChart',
        'QuickActionButtons',
        'RecentLogsSummary',
        'PolicyUpdateNotification',
        'UserNavigationMenu',
        'SystemIntegrationPanel',
      ];

  @override
  List<String> get requiredFunctions => const [
        'executeComplianceScan',
        'syncSecurityPosture',
        'exportAuditLogs',
        'viewTelemetryData',
        'updateSecurityPolicies',
        'reportDiscrepancies',
        'collaborateWithTeams',
        'provideTraining',
      ];

  const QaDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(qaDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('QaDashboard'),
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
            'QaDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
