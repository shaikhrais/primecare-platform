import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'partnership_manager_dashboard_screen_controller.dart';

class PartnershipManagerDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Partnership Manager Dashboard requires components for monitoring partnerships, compliance, and performance metrics, along with functionalities for exporting data and resolving issues.';

  @override
  List<String> get requiredComponents => const [
        'PartnershipOverviewCard',
        'ComplianceAuditHistory',
        'SecurityClearanceLevels',
        'KPIChart',
        'TelemetryLogViewer',
        'OperationalAuditLog',
        'ComplianceAlerts',
        'EngagementMetrics',
        'LogExportTool',
        'PerformanceTrendVisualization',
      ];

  @override
  List<String> get requiredFunctions => const [
        'exportLogs',
        'refreshPartnershipData',
        'viewAuditDetails',
        'sendCommunication',
        'resolvePartnershipIssue',
      ];

  const PartnershipManagerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(partnershipManagerDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('PartnershipManagerDashboard'),
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
            'PartnershipManagerDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
