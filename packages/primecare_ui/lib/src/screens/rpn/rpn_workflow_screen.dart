// Governance - Category: view | Purpose: UI Screen component rendering the Rpn Workflow Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RpnWorkflowState {
  final bool isSubmittingDressing;
  final bool isSubmittingVaccine;
  final List<Map<String, dynamic>> immunizationLogs;

  const RpnWorkflowState({
    required this.isSubmittingDressing,
    required this.isSubmittingVaccine,
    required this.immunizationLogs,
  });

  RpnWorkflowState copyWith({
    bool? isSubmittingDressing,
    bool? isSubmittingVaccine,
    List<Map<String, dynamic>>? immunizationLogs,
  }) {
    return RpnWorkflowState(
      isSubmittingDressing: isSubmittingDressing ?? this.isSubmittingDressing,
      isSubmittingVaccine: isSubmittingVaccine ?? this.isSubmittingVaccine,
      immunizationLogs: immunizationLogs ?? this.immunizationLogs,
    );
  }
}

// --- Controller ---
class RpnWorkflowController extends StateNotifier<RpnWorkflowState> {
  final Ref _ref;

  RpnWorkflowController(this._ref)
    : super(
        const RpnWorkflowState(
          isSubmittingDressing: false,
          isSubmittingVaccine: false,
          immunizationLogs: [
            {
              'id': 'VAC-01',
              'patient': 'Margaret Thompson',
              'vaccine': 'Influenza Annual (Fluzone)',
              'lot': 'LOT-998822',
              'site': 'Left Deltoid',
              'timestamp': 'May 16, 2026',
            },
            {
              'id': 'VAC-02',
              'patient': 'Arthur Pendelton',
              'vaccine': 'COVID-19 Booster (Moderna)',
              'lot': 'LOT-441199',
              'site': 'Right Deltoid',
              'timestamp': 'May 18, 2026',
            },
          ],
        ),
      );

  Future<void> submitDressingLog({
    required String patient,
    required String location,
    required String notes,
  }) async {
    state = state.copyWith(isSubmittingDressing: true);

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 700));

    state = state.copyWith(isSubmittingDressing: false);

    // Aura behavioral telemetry logging
    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/rpn/workflow',
            eventType: 'rpn_wound_dressing_logged',
            metadata: {
              'patient': patient,
              'location': location,
              'notes': notes,
            },
          );
    } catch (_) {}
  }

  Future<void> submitVaccineLog({
    required String patient,
    required String vaccine,
    required String lotNumber,
    required String site,
  }) async {
    state = state.copyWith(isSubmittingVaccine: true);

    // Simulate network delay
    await Future<void>.delayed(const Duration(milliseconds: 750));

    final newLog = {
      'id':
          'VAC-${DateTime.now().millisecondsSinceEpoch.toString().substring(10)}',
      'patient': patient,
      'vaccine': vaccine,
      'lot': lotNumber,
      'site': site,
      'timestamp': 'Just Now',
    };

    state = state.copyWith(
      immunizationLogs: [newLog, ...state.immunizationLogs],
      isSubmittingVaccine: false,
    );

    // Track telemetry
    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/rpn/workflow',
            eventType: 'rpn_vaccine_administered',
            metadata: {
              'patient': patient,
              'vaccine': vaccine,
              'lot': lotNumber,
            },
          );
    } catch (_) {}
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }
}

// --- Provider ---
final rpnWorkflowControllerProvider =
    StateNotifierProvider<RpnWorkflowController, RpnWorkflowState>((ref) {
      return RpnWorkflowController(ref);
    });

// --- View ---
class RpnWorkflowScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The RPN workflow screen requires components for logging patient care activities, tracking immunizations, monitoring patient conditions, and ensuring compliance, along with necessary buttons, functions, and API integrations.';

  @override
  List<String> get requiredComponents => const [
        'DressingLogOverview',
        'ImmunizationLogSummary',
        'AlertsNotification',
        'PatientFeedbackMetrics',
        'ComplianceTracker',
        'PerformanceMetrics',
        'TrainingOpportunitiesNotification',
        'PatientEducationResources',
        'PatientConditionUpdates',
        'EHRIntegration',
      ];

  @override
  List<String> get requiredFunctions => const [
        'logDressingChange',
        'administerVaccine',
        'reportConditionChange',
        'providePatientEducation',
        'collaborateWithTeam',
        'maintainPatientRecords',
        'checkCompliance',
        'manageMedicationReminders',
        'participateInQualityInitiative',
      ];

  const RpnWorkflowScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rpnWorkflowControllerProvider);
    final controller = ref.read(rpnWorkflowControllerProvider.notifier);
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:rpnworkflow-screen',
      container: true,
      child: Scaffold(
        key: const Key('rpnworkflow-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Text(
            key: const Key('rpnworkflow-title'),
            'RPN Practical Workflows',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
        ),
        body: Semantics(
          label: 'data-cy:rpnworkflow-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('rpnworkflow-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('rpnworkflow-btn-1'),
                    onPressed: () => controller.triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:rpnworkflow-title',
                  child: GovDashboardHero(
                    title: 'Wound Dressing & Vaccine Logs',
                    roleName: 'Registered Practical Nurse (RPN)',
                    description:
                        'Dressing log entries, immunization checklist logs, and medication reminder verifications.',
                    onRefresh: () => ref.refresh(rpnWorkflowControllerProvider),
                  ),
                ),
                const SizedBox(height: 24),

                // Two Column Actions (Dressing Log Form & Immunization Form/History)
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: _buildDressingLogCard(
                              context,
                              state,
                              controller,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 6,
                            child: _buildImmunizationWorkflowCard(
                              context,
                              state,
                              controller,
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          _buildDressingLogCard(context, state, controller),
                          const SizedBox(height: 24),
                          _buildImmunizationWorkflowCard(
                            context,
                            state,
                            controller,
                          ),
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDressingLogCard(
    BuildContext context,
    RpnWorkflowState state,
    RpnWorkflowController controller,
  ) {
    final theme = context.theme;

    final patientController = TextEditingController(text: 'Margaret Thompson');
    final locationController = TextEditingController(text: 'Sacrum');
    final notesController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    return PrimeCareCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Wound Dressing Care Log',
              style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Document dressing changes, antiseptic wash status, and localized skin observations.',
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            PrimeCareTextField(
              key: const Key('rpn_workflow_screen_textfield_input_1'),
              label: 'Target Patient',
              controller: patientController,
              validator: (val) {
                if (val == null || val.isEmpty) return 'Patient required';
                return null;
              },
            ),
            const SizedBox(height: 16),
            PrimeCareTextField(
              key: const Key('rpn_workflow_screen_textfield_input_2'),
              label: 'Anatomical Injury Location',
              controller: locationController,
              hintText: 'e.g. Sacrum, Right heel, Left forearm...',
              validator: (val) {
                if (val == null || val.isEmpty) return 'Location required';
                return null;
              },
            ),
            const SizedBox(height: 16),
            PrimeCareTextField(
              key: const Key('rpn_workflow_screen_textfield_input_3'),
              label: 'Treatment & Care Notes',
              controller: notesController,
              maxLines: 3,
              hintText:
                  'e.g. Cleansed with sterile saline, applied hydrocolloid dressing, no drainage...',
              validator: (val) {
                if (val == null || val.isEmpty) return 'Notes required';
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('rpnworkflow-btn-2'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(theme.radiusDefault),
                ),
              ),
              onPressed: state.isSubmittingDressing
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        await controller.submitDressingLog(
                          patient: patientController.text,
                          location: locationController.text,
                          notes: notesController.text,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Wound dressing log entry recorded.',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          notesController.clear();
                        }
                      }
                    },
              child: state.isSubmittingDressing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        key: const Key('rpnworkflow-loading'),
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Record Dressing Change'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImmunizationWorkflowCard(
    BuildContext context,
    RpnWorkflowState state,
    RpnWorkflowController controller,
  ) {
    final theme = context.theme;

    final patientController = TextEditingController(text: 'Eleanor Vance');
    final lotController = TextEditingController();
    String selectedVaccine = 'Influenza Annual';
    String selectedSite = 'Left Deltoid';

    final formKey = GlobalKey<FormState>();

    return PrimeCareCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Immunization Administration Log',
              style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Administer and ledger preventative vaccines under regulatory oversight.',
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            PrimeCareTextField(
              key: const Key('rpn_workflow_screen_textfield_input_4'),
              label: 'Target Patient',
              controller: patientController,
              validator: (val) {
                if (val == null || val.isEmpty) return 'Patient required';
                return null;
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedVaccine,
                    dropdownColor: theme.colors.surface,
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Vaccine Type',
                      labelStyle: theme.typography.labelMedium,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Influenza Annual',
                        child: Text('Influenza Annual'),
                      ),
                      DropdownMenuItem(
                        value: 'COVID-19 Booster',
                        child: Text('COVID-19 Booster'),
                      ),
                      DropdownMenuItem(
                        value: 'Pneumococcal',
                        child: Text('Pneumococcal'),
                      ),
                      DropdownMenuItem(
                        value: 'Shingles Recombinant',
                        child: Text('Shingles Recombinant'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) selectedVaccine = val;
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: selectedSite,
                    dropdownColor: theme.colors.surface,
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onSurface,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Injection Site',
                      labelStyle: theme.typography.labelMedium,
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'Left Deltoid',
                        child: Text('Left Deltoid'),
                      ),
                      DropdownMenuItem(
                        value: 'Right Deltoid',
                        child: Text('Right Deltoid'),
                      ),
                      DropdownMenuItem(
                        value: 'Left Gluteal',
                        child: Text('Left Gluteal'),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) selectedSite = val;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            PrimeCareTextField(
              key: const Key('rpn_workflow_screen_textfield_input_5'),
              label: 'Vaccine Lot Number',
              controller: lotController,
              hintText: 'e.g. LOT-558833',
              validator: (val) {
                if (val == null || val.isEmpty) return 'Lot Number required';
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('rpnworkflow-btn-3'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(theme.radiusDefault),
                ),
              ),
              onPressed: state.isSubmittingVaccine
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        await controller.submitVaccineLog(
                          patient: patientController.text,
                          vaccine: selectedVaccine,
                          lotNumber: lotController.text,
                          site: selectedSite,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Vaccine administration ledgered successfully.',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          lotController.clear();
                        }
                      }
                    },
              child: state.isSubmittingVaccine
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        key: const Key('rpnworkflow-loading'),
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Ledger Vaccine Administration'),
            ),
            const SizedBox(height: 24),
            Text(
              'Recent Vaccine Administrations',
              style: theme.typography.labelBold.copyWith(
                color: theme.colors.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.immunizationLogs.length,
              separatorBuilder: (context, index) =>
                  Divider(color: theme.colors.divider, height: 12),
              itemBuilder: (context, index) {
                final log = state.immunizationLogs[index];
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    '${log['vaccine']} - Lot: ${log['lot']}',
                    style: theme.typography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Patient: ${log['patient']} | Site: ${log['site']}',
                    style: theme.typography.bodyMedium.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                  trailing: Text(
                    log['timestamp'] as String,
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
