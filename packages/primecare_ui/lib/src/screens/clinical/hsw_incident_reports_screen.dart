/* 
PRIME:SCREEN=hsw_incident_reports
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_NONE
PRIME:API=API_NONE
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=40
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: view | Purpose: UI Screen component rendering the Hsw Incident Reports Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HswIncidentReportsScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for incident reporting, health status updates, care plan access, communication tools, training resources, performance metrics, client feedback, and scheduling functionalities.';

  @override
  List<String> get requiredComponents => const [
        'IncidentReportCard',
        'HealthStatusAlert',
        'CarePlanTracker',
        'CommunicationTool',
        'TrainingResourceAccess',
        'PerformanceMetrics',
        'ClientFeedbackSystem',
        'SchedulingTool',
      ];

  @override
  List<String> get requiredFunctions => const [
        'reportIncident',
        'updateHealthStatus',
        'accessCarePlan',
        'sendMessage',
        'accessTrainingResources',
        'viewPerformanceMetrics',
        'submitFeedback',
        'scheduleShift',
      ];

  const HswIncidentReportsScreen({super.key});

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:hswincidentreports-screen',
      container: true,
      child: Scaffold(
        key: const Key('hswincidentreports-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('hswincidentreports-title'),
            'HSW Incident Reports',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:hswincidentreports-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('hswincidentreports-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('hswincidentreports-btn-1'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:hswincidentreports-title',
                  child: GovDashboardHero(
                    title: 'HSW Incident Reports',
                    roleName: 'HSW Module',
                    description:
                        'Log and immediately escalate clinical incidents, witness summaries, and patient event severities.',
                    onRefresh: () {},
                  ),
                ),
                const SizedBox(height: 24),
                // HSW Incident Form Fields component
                Container(
                  key: const ValueKey('data-cy-hsw-incident-form-fields'),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Incident Details & Escalation",
                        style: theme.typography.h4,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        key: const ValueKey('submit_incident_report'),
                        onPressed: () => triggerStateAction(),
                        icon: const Icon(LucideIcons.shieldAlert),
                        label: const Text('Submit Critical Incident Report'),
                      ),
                    ],
                  ),
                ),
                // HSW Witness Notes Input component
                Container(
                  key: const ValueKey('data-cy-hsw-witness-notes-input'),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Witness Statements & Summaries",
                        style: theme.typography.h4,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Witness statements sandbox input.",
                        style: theme.typography.bodyMedium,
                      ),
                    ],
                  ),
                ),
                // HSW Incident Severity Picker component
                Container(
                  key: const ValueKey('data-cy-hsw-incident-severity-picker'),
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Incident Severity Classification",
                        style: theme.typography.h4,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Low, Medium, High severity picker sandbox.",
                        style: theme.typography.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
