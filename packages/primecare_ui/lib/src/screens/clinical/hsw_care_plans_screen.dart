/* 
PRIME:SCREEN=hsw_care_plans
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
// Governance - Category: view | Purpose: UI Screen component rendering the Hsw Care Plans Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

class HswCarePlansScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for managing patient care plans, medication reminders, communication logs, and documentation, along with necessary buttons, functions, APIs, and responsive design for various platforms.';

  @override
  List<String> get requiredComponents => const [
        'PatientCarePlanOverview',
        'MedicationReminderAlert',
        'CommunicationLog',
        'DocumentationSection',
        'TrainingComplianceTracker',
        'PerformanceMetrics',
        'IncidentReportForm',
        'ResourceLinks',
        'VisitCalendar',
        'EmergencyContactAccess',
      ];

  @override
  List<String> get requiredFunctions => const [
        'recordPatientProgress',
        'sendMedicationReminder',
        'logCommunication',
        'reportIncident',
        'accessTrainingResources',
        'scheduleVisit',
      ];

  const HswCarePlansScreen({super.key});

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }

  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:hswcareplans-screen',
      container: true,
      child: Scaffold(
        key: const Key('hswcareplans-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('hswcareplans-title'),
            'HSW Patient Care Plans',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:hswcareplans-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('hswcareplans-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('hswcareplans-btn-1'),
                    onPressed: () => triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:hswcareplans-title',
                  child: GovDashboardHero(
                    title: 'HSW Patient Care Plans',
                    roleName: 'HSW Module',
                    description:
                        'Access and review personalized patient care plans, dietary outlines, and medication support trackers.',
                    onRefresh: () {},
                  ),
                ),
                const SizedBox(height: 24),
                // HSW Dietary Guidelines Viewer component
                Container(
                  key: const ValueKey('data-cy-hsw-dietary-guidelines-viewer'),
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
                        "Dietary Guidelines & Restrictions",
                        style: theme.typography.h4,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Dietary details sandbox viewer.",
                        style: theme.typography.bodyMedium,
                      ),
                    ],
                  ),
                ),
                // HSW Mobility Aids Panel component
                Container(
                  key: const ValueKey('data-cy-hsw-mobility-aids-panel'),
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
                        "Mobility Aids & Transfer Details",
                        style: theme.typography.h4,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Mobility support instructions.",
                        style: theme.typography.bodyMedium,
                      ),
                    ],
                  ),
                ),
                // HSW Medication Checklist Widget component
                Container(
                  key: const ValueKey(
                    'data-cy-hsw-medication-checklist-widget',
                  ),
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
                        "Medication Reminders & Checklist",
                        style: theme.typography.h4,
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        key: const ValueKey('sign_off_care_plan_review'),
                        onPressed: () => triggerStateAction(),
                        icon: const Icon(LucideIcons.checkSquare),
                        label: const Text('Sign-Off Care Plan Pre-Review'),
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
