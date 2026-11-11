import 'package:primecare_ui/primecare_ui.dart' show PrimeText;
import 'package:primecare_ui/primecare_ui.dart' show DashboardLoadingWidget;
import 'package:primecare_ui/primecare_ui.dart' show PrimePageScaffold;
import 'package:primecare_ui/primecare_ui.dart' show PrimeIcon;
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'patient_profile_screen_controller.dart';
import 'patient_unavailable_text.dart';

class PatientProfileScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The patient profile screen requires components for monitoring performance, compliance, and audit logs, along with buttons for executing scans and refreshing data.';

  @override
  List<String> get requiredComponents => const [
        'GovMetricCard',
        'GovTelemetryChart',
        'ComplianceStatusIndicator',
        'OperationalAuditLog',
        'ErrorLogDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'executeComplianceScan',
        'triggerManualRefresh',
        'monitorTelemetryLogs',
        'reviewAuditLogs',
      ];

  const PatientProfileScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(patientProfileScreenControllerProvider);

    return PrimePageScaffold(
      title: const PrimeText('PatientProfile'),
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
          PrimeIcon(Icons.info_outline, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
          const SizedBox(height: 16),
          PrimeText(
            patientUnavailableText(context, 'profile'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }
}
