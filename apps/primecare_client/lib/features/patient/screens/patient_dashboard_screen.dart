import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'patient_dashboard_screen_controller.dart';
import 'patient_unavailable_text.dart';

class PatientDashboardScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The patient dashboard requires components for monitoring KPIs, telemetry, compliance, and security, along with buttons for refreshing data and executing audits.';

  @override
  List<String> get requiredComponents => const [
        'KPIIndicator',
        'TelemetryLog',
        'ComplianceStatus',
        'RefreshButton',
        'AuditScanButton',
        'SecurityPostureIndicator',
        'SecurityPolicyUpdater',
        'AuditLogExporter',
      ];

  @override
  List<String> get requiredFunctions => const [
        'triggerManualRefresh',
        'executeAuditScan',
        'checkCompliance',
      ];

  const PatientDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientDashboardScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientDashboard'),
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
          Icon(Icons.info_outline, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(height: 16),
          Text(
            patientUnavailableText(context, 'dashboard'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
