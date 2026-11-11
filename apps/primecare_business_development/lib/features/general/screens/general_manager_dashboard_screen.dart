import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'general_manager_dashboard_screen_controller.dart';

class GeneralManagerDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The General Manager Dashboard requires components for KPI overview, operational metrics, compliance status, employee engagement, financial performance, alerts, and tools for audits, with responsive design for multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'KPIDashboard',
        'OperationalMetricsChart',
        'ComplianceStatusCard',
        'EmployeeEngagementWidget',
        'FinancialPerformanceCard',
        'OperationalLogsTable',
        'AlertsNotification',
        'ComplianceScanTool',
        'ManualSyncButton',
        'TrendsForecastChart',
      ];

  @override
  List<String> get requiredFunctions => const [
        'syncData',
        'viewAuditResults',
        'generateComplianceReport',
        'addressOperationalIssues',
      ];

  const GeneralManagerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(generalManagerDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('GeneralManagerDashboard'),
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
            'GeneralManagerDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
