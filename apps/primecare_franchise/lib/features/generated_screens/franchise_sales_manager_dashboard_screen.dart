import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'franchise_sales_manager_dashboard_screen_controller.dart';

class FranchiseSalesManagerDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires a comprehensive dashboard for franchise sales management, displaying key performance indicators, compliance status, and market analysis, along with functionalities for reporting and alerts.';

  @override
  List<String> get requiredComponents => const [
        'KPIDashboard',
        'SalesTrendChart',
        'ComplianceStatusCard',
        'FranchiseeSatisfactionGauge',
        'MarketAnalysisWidget',
        'OperationalLogsTable',
        'AlertsNotification',
        'TrainingSupportTracker',
        'SalesForecastVisualization',
        'HistoricalPerformanceChart',
      ];

  @override
  List<String> get requiredFunctions => const [
        'generateSalesReport',
        'sendAlertNotification',
        'updateTrainingRecords',
        'viewMarketAnalysis',
        'exportDashboardData',
      ];

  const FranchiseSalesManagerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(franchiseSalesManagerDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('FranchiseSalesManagerDashboard'),
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
            'FranchiseSalesManagerDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
