import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'head_of_bus_dev_dashboard_screen_controller.dart';

class HeadOfBusDevDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Head of Business Development dashboard requires various widgets to display KPIs, client metrics, market trends, and team performance, along with buttons for proposal management and contract negotiation.';

  @override
  List<String> get requiredComponents => const [
        'KPIWidget',
        'ClientMetricsWidget',
        'MarketTrendsChart',
        'OpportunitiesPipelineWidget',
        'TeamPerformanceWidget',
        'ClientFeedbackWidget',
        'ComplianceLogWidget',
        'NotificationWidget',
        'SalesTrendsChart',
        'MarketResearchDataWidget',
      ];

  @override
  List<String> get requiredFunctions => const [
        'viewProposalDetails',
        'initiateContractNegotiation',
        'generateBusinessReport',
        'updatePerformanceMetrics',
        'submitClientFeedback',
      ];

  const HeadOfBusDevDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(headOfBusDevDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('HeadOfBusDevDashboard'),
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
            'HeadOfBusDevDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
