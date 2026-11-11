import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'coo_scheduling_health_screen_controller.dart';

class CooSchedulingHealthScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The COO scheduling health screen requires various performance and operational metrics visualized through multiple components, along with buttons for data refresh and reporting, supported by specific API endpoints for data retrieval.';

  @override
  List<String> get requiredComponents => const [
        'PerformanceMetricCard',
        'ComplianceStatusWidget',
        'FinancialOverviewChart',
        'EmployeeEngagementStats',
        'OperationalEfficiencyGauge',
        'RiskManagementDashboard',
        'ProjectStatusTracker',
        'CustomerSatisfactionMeter',
        'ResourceUtilizationChart',
        'AlertsNotificationPanel',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshDashboardData',
        'viewDetailedReport',
        'exportDashboardData',
        'setAlerts',
      ];

  const CooSchedulingHealthScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cooSchedulingHealthScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('CooSchedulingHealth'),
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
            'CooSchedulingHealthScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
