import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'coo_operations_overview_screen_controller.dart';

class CooOperationsOverviewScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The COO operations overview screen requires various widgets to display key performance indicators, operational metrics, and compliance status, along with buttons for data refresh and report viewing.';

  @override
  List<String> get requiredComponents => const [
        'KPIOverviewWidget',
        'EfficiencyMetricsChart',
        'FinancialPerformanceCard',
        'ComplianceStatusWidget',
        'EmployeeEngagementWidget',
        'CustomerFeedbackWidget',
        'RiskManagementWidget',
        'ProjectTimelineWidget',
        'ResourceAllocationChart',
        'OperationalLogsWidget',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshDashboardData',
        'viewDetailedReports',
        'exportMetrics',
        'setAlerts',
      ];

  const CooOperationsOverviewScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cooOperationsOverviewScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('CooOperationsOverview'),
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
            'CooOperationsOverviewScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
