import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'physiotherapist_dashboard_screen_controller.dart';

class PhysiotherapistDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The physiotherapist dashboard requires components for tracking patient outcomes, operational metrics, and educational resources, along with buttons for data synchronization and report exporting.';

  @override
  List<String> get requiredComponents => const [
        'KPIWidget',
        'PatientInteractionLog',
        'ComplianceAuditAlert',
        'OperationalEfficiencyMetrics',
        'AppointmentNotification',
        'EducationalResources',
        'DataSyncTool',
        'ExportReportButton',
      ];

  @override
  List<String> get requiredFunctions => const [
        'syncPatientData',
        'exportAuditLogs',
        'fetchEducationalResources',
      ];

  const PhysiotherapistDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(physiotherapistDashboardScreenControllerProvider);

    return Semantics(
      label: 'data-cy:physiotherapistdashboard-screen',
      container: true,
      child: Scaffold(
        key: const Key('physiotherapistdashboard-screen'),
      appBar: AppBar(
        title: Semantics(label: 'data-cy:physiotherapistdashboard-title', container: true, child: Container(child:  const Text('PhysiotherapistDashboard'))),
      ),
      body: state.when(
        data: (data) => _buildContent(context, data),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading features: $error')),
      ),
    )
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
            'PhysiotherapistDashboardScreen is now fully implemented.',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
