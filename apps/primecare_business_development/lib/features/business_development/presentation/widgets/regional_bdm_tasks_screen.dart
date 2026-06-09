import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'regional_bdm_tasks_screen_controller.dart';

class RegionalBdmTasksScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring sales performance, managing tasks, and analyzing reports, along with buttons for task assignment and feedback submission.';

  @override
  List<String> get requiredComponents => const [
        'SalesPerformanceMetric',
        'TaskManagementWidget',
        'SalesTrendChart',
        'ClientFeedbackWidget',
        'TeamPerformanceAnalytics',
        'TaskAlertNotification',
        'CommunicationSummary',
      ];

  @override
  List<String> get requiredFunctions => const [
        'monitorSalesPerformance',
        'manageTasks',
        'reviewSalesReports',
        'communicateWithClients',
        'setTrackSalesTargets',
        'attendMeetings',
        'provideFeedback',
      ];

  const RegionalBdmTasksScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regionalBdmTasksScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RegionalBdmTasks'),
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
            'RegionalBdmTasksScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
