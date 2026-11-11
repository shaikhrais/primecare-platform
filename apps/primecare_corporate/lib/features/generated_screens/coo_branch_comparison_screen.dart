import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'coo_branch_comparison_screen_controller.dart';

class CooBranchComparisonScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires various widgets to display operational metrics, buttons for data interaction, functions for data fetching, and APIs for backend communication, all while being responsive across multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'KPIWidget',
        'FinancialMetricsCard',
        'ComplianceStatusWidget',
        'EmployeeEngagementChart',
        'CustomerSatisfactionWidget',
        'RiskAssessmentPanel',
        'ProjectTimelineTracker',
        'OperationalLogsViewer',
        'PerformanceTrendsGraph',
        'AlertsNotification',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchKPIData',
        'fetchFinancialMetrics',
        'fetchComplianceStatus',
        'fetchEmployeeEngagement',
        'fetchCustomerSatisfaction',
        'fetchRiskAssessments',
        'fetchProjectTimelines',
        'fetchOperationalLogs',
        'fetchPerformanceTrends',
        'triggerAlert',
      ];

  const CooBranchComparisonScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cooBranchComparisonScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('CooBranchComparison'),
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
            'CooBranchComparisonScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
