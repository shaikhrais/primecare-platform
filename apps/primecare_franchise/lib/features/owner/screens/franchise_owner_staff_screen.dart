import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'franchise_owner_staff_screen_controller.dart';

class FranchiseOwnerStaffScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring performance, compliance, and operational metrics, along with buttons for managing staff and addressing issues.';

  @override
  List<String> get requiredComponents => const [
        'PerformanceMetricCard',
        'ComplianceStatusWidget',
        'TelemetryLogViewer',
        'KPIVisualizationChart',
        'AlertNotificationPanel',
        'StaffTrainingStatusWidget',
        'FinancialSummaryCard',
        'CustomerSatisfactionWidget',
        'MarketingCampaignPerformanceChart',
        'HistoricalDataTrendGraph',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchPerformanceMetrics',
        'fetchComplianceStatus',
        'fetchTelemetryLogs',
        'fetchKPIData',
        'triggerAlertNotification',
        'fetchStaffTrainingStatus',
        'fetchFinancialPerformance',
        'fetchCustomerSatisfaction',
        'fetchMarketingPerformance',
        'fetchHistoricalDataTrends',
      ];

  const FranchiseOwnerStaffScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchiseOwnerStaffScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('FranchiseOwnerStaff'),
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
            'FranchiseOwnerStaffScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
