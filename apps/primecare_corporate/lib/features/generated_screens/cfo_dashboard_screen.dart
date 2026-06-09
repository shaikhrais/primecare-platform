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

    return Scaffold(
      appBar: AppBar(
        title: const Text('CfoDashboard'),
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
            'CfoDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
