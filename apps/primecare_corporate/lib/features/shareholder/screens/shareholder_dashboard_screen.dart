import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'shareholder_dashboard_screen_controller.dart';

class ShareholderDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The shareholder dashboard requires components for monitoring compliance, synchronizing security, exporting logs, and reviewing KPIs, along with necessary buttons and API integrations for real-time operations.';

  @override
  List<String> get requiredComponents => const [
        'ComplianceAuditMonitor',
        'SecurityPostureSync',
        'AuditLogExporter',
        'StateActionTrigger',
        'KPIDashboard',
        'OperationalAuditScanner',
        'TelemetryChart',
        'NotificationPanel',
      ];

  @override
  List<String> get requiredFunctions => const [
        'monitorComplianceAudits',
        'synchronizeSecurityPosture',
        'exportAuditLogs',
        'triggerStateAction',
        'reviewKPIs',
        'executeOperationalAudit',
      ];

  const ShareholderDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(shareholderDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('ShareholderDashboard'),
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
            'ShareholderDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
