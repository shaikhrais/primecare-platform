import 'package:primecare_ui/primecare_ui.dart';

class PswIncidentReportScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring client health, reporting incidents, and facilitating communication among PSWs, along with necessary buttons and functions for managing care and compliance.';

  @override
  List<String> get requiredComponents => const [
        'ClientHealthStatusCard',
        'IncidentReportForm',
        'ComplianceAuditAlert',
        'ActivityMetricsChart',
        'TeamCommunicationTool',
        'TrainingResourceSection',
        'ClientFeedbackSurvey',
        'MedicationAlert',
        'PerformanceMetricsTable',
        'StaffingResourceAllocation',
      ];

  @override
  List<String> get requiredFunctions => const [
        'reportIncident',
        'updateHealthStatus',
        'viewComplianceAudit',
        'logActivity',
        'sendMessage',
        'accessTrainingResources',
        'submitFeedback',
        'scheduleMedication',
        'viewPerformanceMetrics',
        'allocateResources',
      ];

  const PswIncidentReportScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final title = 'PswIncidentReportScreen';

    return Cy(
      id: 'pswincidentreport-screen',
      child: Scaffold(
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(label: 'data-cy:pswincidentreport-title', container: true, child: Container(child:  Text(
            key: const Key('pswincidentreport-title'),
            title,
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ))),
        ),
        body: Semantics(
          label: 'data-cy:pswincidentreport-content',
          container: true,
          child: Cy(
          id: 'pswincidentreport-content',
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Governed operational interface to monitor patient parameters, review compliance posture, and maintain Zero-Trust synchronization.',
                        style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}
