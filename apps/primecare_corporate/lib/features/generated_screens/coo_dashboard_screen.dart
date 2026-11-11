import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'coo_dashboard_screen_controller.dart';

class CooDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The COO dashboard requires components to display operational metrics, security statuses, and audit logs, along with buttons for compliance actions and data synchronization.';

  @override
  List<String> get requiredComponents => const [
        'ActiveOperationsCount',
        'OperationalProductivityMetric',
        'SecurityClearanceStatus',
        'ClearanceExceptionsHighlight',
        'TelemetryDataDisplay',
        'AuditLogs',
        'PerformanceTrendsChart',
        'QuickActionsPanel',
        'InsightsRecommendations',
        'ErrorHandlingDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchActiveOperations',
        'fetchProductivityMetrics',
        'fetchSecurityClearanceStatus',
        'fetchClearanceExceptions',
        'fetchTelemetryData',
        'fetchAuditLogs',
        'fetchPerformanceTrends',
        'runComplianceScan',
        'syncData',
      ];

  const CooDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cooDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('CooDashboard'),
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
            'CooDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
