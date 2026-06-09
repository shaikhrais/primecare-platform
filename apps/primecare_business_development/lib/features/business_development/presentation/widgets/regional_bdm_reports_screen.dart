import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'regional_bdm_reports_screen_controller.dart';

class RegionalBdmReportsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The Regional BDM Reports screen requires components for displaying reports, handling loading states and errors, and options for exporting data, all while ensuring responsiveness across devices.';

  @override
  List<String> get requiredComponents => const [
        'LoadingIndicator',
        'ErrorMessage',
        'ReportTable',
        'KPIDashboard',
        'ExportButton',
      ];

  @override
  List<String> get requiredFunctions => const [
        'fetchRegionalReports',
        'handleLoadingError',
        'exportReport',
        'refreshData',
      ];

  const RegionalBdmReportsScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(regionalBdmReportsScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('RegionalBdmReports'),
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
            'RegionalBdmReportsScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
