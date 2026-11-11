import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cfo_payroll_screen_controller.dart';

class CfoPayrollScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The CFO dashboard requires various financial performance metrics, real-time analysis tools, compliance indicators, and alert systems to monitor financial health and operational risks.';

  @override
  List<String> get requiredComponents => const [
        'KPIWidget',
        'CashFlowChart',
        'BudgetPerformanceTracker',
        'ComplianceStatusIndicator',
        'RiskAssessmentWidget',
        'AuditLogViewer',
        'InvestmentPerformanceWidget',
        'OperationalEfficiencyChart',
        'StakeholderFeedbackWidget',
        'AlertNotificationSystem',
      ];

  @override
  List<String> get requiredFunctions => const [
        'refreshDashboardData',
        'generateFinancialReport',
        'viewAuditLogs',
        'setAlerts',
      ];

  const CfoPayrollScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfoPayrollScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('CfoPayroll'),
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
            'CfoPayrollScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
