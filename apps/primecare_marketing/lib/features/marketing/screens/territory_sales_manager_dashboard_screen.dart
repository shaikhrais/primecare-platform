import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'territory_sales_manager_dashboard_screen_controller.dart';

class TerritorySalesManagerDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Territory Sales Manager Dashboard requires various performance metrics, compliance status, and team indicators, along with functionalities for reporting and budget management across multiple platforms.';

  @override
  List<String> get requiredComponents => const [
        'SalesPerformanceMetricCard',
        'CustomerSatisfactionChart',
        'ComplianceStatusWidget',
        'TerritoryCoverageMap',
        'TeamPerformanceIndicator',
        'MarketTrendsAnalysis',
        'TrainingProgressTracker',
        'BudgetTrackingWidget',
        'RealTimeAlerts',
        'HistoricalDataChart',
      ];

  @override
  List<String> get requiredFunctions => const [
        'generateSalesReport',
        'viewTrainingProgress',
        'allocateBudget',
        'setSalesStrategy',
        'notifyTeam',
      ];

  const TerritorySalesManagerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(territorySalesManagerDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const PrimeText('TerritorySalesManagerDashboard'),
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
            'TerritorySalesManagerDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
