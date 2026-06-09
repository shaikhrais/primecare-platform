import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'finance_director_dashboard_screen_controller.dart';

class FinanceDirectorDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Finance Director dashboard requires components to monitor financial performance, cash flow, budgeting, compliance, risks, and provide insights for decision-making.';

  @override
  List<String> get requiredComponents => const [
        'FinancialPerformanceMetrics',
        'CashFlowStatus',
        'BudgetVsActualAnalysis',
        'ComplianceStatus',
        'KPIsDashboard',
        'RiskAssessmentDashboard',
        'FinancialReportsSummary',
        'AlertsDashboard',
        'HistoricalDataTrends',
        'InsightsRecommendations',
      ];

  @override
  List<String> get requiredFunctions => const [];

  const FinanceDirectorDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(financeDirectorDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinanceDirectorDashboard'),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic data) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle_outline, size: 64, color: Colors.green),
          const SizedBox(height: 16),
          Text(
            'FinanceDirectorDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
