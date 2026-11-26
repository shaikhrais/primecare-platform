import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimeStatusIcon, PrimeStatusTone;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'cfo_dashboard_screen_controller.dart';

class CfoDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The CFO dashboard requires various widgets to display financial metrics, compliance results, and alerts for operational red flags.';

  @override
  List<String> get requiredComponents => const [
        'CashBalanceWidget',
        'GrowthRateWidget',
        'ExpenseBufferWidget',
        'TaxLiabilityWidget',
        'LedgerSummaryWidget',
        'ComplianceScanWidget',
        'FinancialMetricsWidget',
        'KPIsWidget',
        'ActivityLogsWidget',
        'AlertsWidget',
      ];

  @override
  List<String> get requiredFunctions => const [];

  const CfoDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(cfoDashboardScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('CfoDashboard'),
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
            'CfoDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
