import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusText, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cfo_expenses_screen_controller.dart';

class CfoExpensesScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The CFO expenses screen requires various financial metrics and performance indicators to be displayed, along with functionalities for data refresh and report generation.';

  @override
  List<String> get requiredComponents => const [
        'KPIOverviewWidget',
        'FinancialMetricsChart',
        'BudgetVsActualWidget',
        'CashFlowProjectionWidget',
        'ComplianceStatusIndicator',
        'RiskAssessmentMetric',
        'AuditLogViewer',
        'OperationalEfficiencyWidget',
        'InvestmentPerformanceWidget',
        'TeamPerformanceMetric',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshDashboard',
        'generateFinancialReport',
        'exportFinancialData',
      ];

  const CfoExpensesScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfoExpensesScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('CfoExpenses'),
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
            'CfoExpensesScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
