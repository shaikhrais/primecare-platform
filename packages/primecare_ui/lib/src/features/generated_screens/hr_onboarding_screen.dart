// Governance - Category: view | Purpose: UI Screen component rendering the Hr Onboarding Screen workspace interface.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class HrOnboardingState {
  final List<Map<String, dynamic>> applicants;
  final String activeStage;
  final String? selectedApplicantId;
  final bool processingAction;

  const HrOnboardingState({
    required this.applicants,
    required this.activeStage,
    this.selectedApplicantId,
    required this.processingAction,
  });

  HrOnboardingState copyWith({
    List<Map<String, dynamic>>? applicants,
    String? activeStage,
    String? selectedApplicantId,
    bool? processingAction,
  }) {
    return HrOnboardingState(
      applicants: applicants ?? this.applicants,
      activeStage: activeStage ?? this.activeStage,
      selectedApplicantId: selectedApplicantId ?? this.selectedApplicantId,
      processingAction: processingAction ?? this.processingAction,
    );
  }
}

// --- Controller ---
class HrOnboardingController extends StateNotifier<HrOnboardingState> {
  final Ref _ref;

  HrOnboardingController(this._ref)
      : super(
          const HrOnboardingState(
            applicants: [
              {
                'id': 'app-301',
                'name': 'Amanda Sterling',
                'role': 'Registered Practical Nurse (RPN) Candidate',
                'stage': 'interview',
                'complianceScore': 85.0,
                'checklist': {
                  'cprCertified': true,
                  'criminalRecordCheck': true,
                  'immunizationVerified': false,
                  'referenceChecks': true,
                },
                'email': 'a.sterling@primecare-talent.com',
                'phone': '+1 (555) 019-2834',
              },
              {
                'id': 'app-302',
                'name': 'Marcus Vance',
                'role': 'Personal Support Worker (PSW) Candidate',
                'stage': 'background',
                'complianceScore': 60.0,
                'checklist': {
                  'cprCertified': true,
                  'criminalRecordCheck': false,
                  'immunizationVerified': false,
                  'referenceChecks': false,
                },
                'email': 'm.vance@primecare-talent.com',
                'phone': '+1 (555) 014-9856',
              },
              {
                'id': 'app-303',
                'name': 'Dr. Alistair Vance',
                'role': 'RN Clinical Supervisor',
                'stage': 'applied',
                'complianceScore': 25.0,
                'checklist': {
                  'cprCertified': true,
                  'criminalRecordCheck': false,
                  'immunizationVerified': false,
                  'referenceChecks': false,
                },
                'email': 'a.vance@primecare-clinical.org',
                'phone': '+1 (555) 012-7643',
              },
            ],
            activeStage: 'all',
            selectedApplicantId: null,
            processingAction: false,
          ),
        );

  void setStage(String stage) {
    state = state.copyWith(activeStage: stage);
  }

  void selectApplicant(String? id) {
    state = state.copyWith(selectedApplicantId: id);
  }

  void toggleChecklistItem(String applicantId, String itemKey) {
    final updated = state.applicants.map((a) {
      if (a['id'] == applicantId) {
        final checklist = Map<String, bool>.from(a['checklist'] as Map);
        checklist[itemKey] = !(checklist[itemKey] ?? false);

        // Recompute compliance ratio
        final verifiedCount = checklist.values.where((v) => v).length;
        final newScore = (verifiedCount / checklist.length) * 100.0;

        return {
          ...a,
          'checklist': checklist,
          'complianceScore': newScore,
        };
      }
      return a;
    }).toList();

    state = state.copyWith(applicants: updated);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/hr_onboarding',
            eventType: 'hr_candidate_checklist_toggled',
            metadata: {'applicantId': applicantId, 'itemKey': itemKey},
          );
    } catch (_) {}
  }

  void promoteToRoster(String applicantId) {
    state = state.copyWith(processingAction: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/hr_onboarding',
            eventType: 'hr_candidate_promoted_to_staff',
            metadata: {'applicantId': applicantId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 500), () {
      final updated = state.applicants.map((a) {
        if (a['id'] == applicantId) {
          return {
            ...a,
            'stage': 'hired',
            'complianceScore': 100.0,
            'checklist': {
              'cprCertified': true,
              'criminalRecordCheck': true,
              'immunizationVerified': true,
              'referenceChecks': true,
            },
          };
        }
        return a;
      }).toList();

      state = state.copyWith(
        processingAction: false,
        selectedApplicantId: null,
        applicants: updated,
      );
    });
  }
}

// --- Provider ---
final hrOnboardingControllerProvider =
    StateNotifierProvider<HrOnboardingController, HrOnboardingState>((ref) {
  return HrOnboardingController(ref);
});

// --- View ---
class HrOnboardingScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The HR Onboarding screen requires components for viewing and managing applicant details, filtering applicants by stage, and toggling checklist items, along with APIs for data retrieval and actions.';

  @override
  List<String> get requiredComponents => const [
        'ApplicantList',
        'ApplicantDetailView',
        'ChecklistToggle',
        'ComplianceScoreChart',
        'StageDistributionOverview',
        'AlertsNotification',
        'QuickAccessButtons',
      ];

  @override
  List<String> get requiredFunctions => const [
        'viewApplicantDetails',
        'filterApplicants',
        'toggleChecklistItem',
        'promoteApplicant',
        'generateComplianceReport',
      ];

  const HrOnboardingScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(hrOnboardingControllerProvider);
    final controller = ref.read(hrOnboardingControllerProvider.notifier);
    final theme = context.theme;

    final filteredApplicants = state.applicants.where((a) {
      if (state.activeStage == 'all') return true;
      return a['stage'] == state.activeStage;
    }).toList();

    final selectedApp = state.selectedApplicantId != null
        ? state.applicants.firstWhere((a) => a['id'] == state.selectedApplicantId)
        : null;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.users, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Recruiting & Onboarding Desk',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sidebar: Candidate Index
          Expanded(
            flex: 5,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HR Candidate Pipeline',
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Coordination checkmarks and electronic sign-offs.',
                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),

                  // Pipeline Category Tabs
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildStageTab(context, 'All Applicants', 'all', state.activeStage, controller.setStage),
                        const SizedBox(width: 8),
                        _buildStageTab(context, 'Interviewing', 'interview', state.activeStage, controller.setStage),
                        const SizedBox(width: 8),
                        _buildStageTab(context, 'Background check', 'background', state.activeStage, controller.setStage),
                        const SizedBox(width: 8),
                        _buildStageTab(context, 'Hired Roster', 'hired', state.activeStage, controller.setStage),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // List of Candidates
                  Text(
                    'Applicants Matching Stage (${filteredApplicants.length})',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...filteredApplicants.map((app) {
                    final isSelected = state.selectedApplicantId == app['id'];
                    final compliance = app['complianceScore'] as double;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        border: Border.all(
                          color: isSelected ? theme.colors.primary : theme.colors.border,
                          width: isSelected ? 2 : 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () => controller.selectApplicant((app['id'] as String?)),
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    (app['name'] as String),
                                    style: theme.typography.bodyLarge.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: theme.colors.onSurface,
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: theme.colors.primary.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(theme.radiusSm),
                                    ),
                                    child: Text(
                                      app['stage'].toString().toUpperCase(),
                                      style: theme.typography.labelBold.copyWith(color: theme.colors.primary),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (app['role'] as String),
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                              const SizedBox(height: 12),
                              // Compliance progress
                              Row(
                                children: [
                                  Expanded(
                                    child: LinearProgressIndicator(
                                      value: compliance / 100,
                                      backgroundColor: theme.colors.border,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        compliance > 80
                                            ? Colors.green
                                            : compliance > 50
                                                ? Colors.amber
                                                : Colors.red,
                                      ),
                                      minHeight: 6,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    '${compliance.toInt()}% Compliance',
                                    style: theme.typography.labelBold.copyWith(
                                      color: compliance > 80
                                          ? Colors.green
                                          : compliance > 50
                                              ? Colors.amber
                                              : Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Central Operations Detail Checklists Panel
          Expanded(
            flex: 5,
            child: Container(
              color: theme.colors.surface.withValues(alpha: 0.4),
              padding: const EdgeInsets.all(24),
              child: selectedApp != null
                  ? Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (selectedApp['name'] as String),
                                    style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    (selectedApp['email'] as String),
                                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                  ),
                                ],
                              ),
                              IconButton(key: const Key('hr_onboarding_screen_iconbutton_button_1'), 
                                icon: const Icon(LucideIcons.x),
                                onPressed: () => controller.selectApplicant(null),
                              ),
                            ],
                          ),
                          const Divider(height: 32),
                          Text(
                            'Electronic Verification Credentials Checklists',
                            style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView(
                              children: [
                                _buildChecklistItem(
                                  context,
                                  'CPR/First Aid Certification Verified',
                                  'cprCertified',
                                  selectedApp,
                                  controller,
                                ),
                                _buildChecklistItem(
                                  context,
                                  'Criminal Record Background Audit Complete',
                                  'criminalRecordCheck',
                                  selectedApp,
                                  controller,
                                ),
                                _buildChecklistItem(
                                  context,
                                  'Immunization & Health Declarations Verified',
                                  'immunizationVerified',
                                  selectedApp,
                                  controller,
                                ),
                                _buildChecklistItem(
                                  context,
                                  'Professional Reference Checks Signed-Off',
                                  'referenceChecks',
                                  selectedApp,
                                  controller,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          // Promotion trigger
                          SizedBox(
                            width: double.infinity,
                            child: state.processingAction
                                ? const Center(child: CircularProgressIndicator())
                                : ElevatedButton(key: const Key('hr_onboarding_screen_elevatedbutton_button_1'), 
                                    onPressed: (selectedApp['complianceScore'] as double) >= 80.0
                                        ? () => controller.promoteToRoster((selectedApp['id'] as String))
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.symmetric(vertical: 14),
                                      disabledBackgroundColor: theme.colors.border,
                                    ),
                                    child: Text(
                                      (selectedApp['complianceScore'] as double) >= 80.0
                                          ? 'Approve & Promote to Active Staff Roster'
                                          : 'Compliance Score Too Low to Promote (min 80%)',
                                    ),
                                  ),
                          ),
                        ],
                      )
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(LucideIcons.userPlus, size: 64, color: theme.colors.border),
                          const SizedBox(height: 16),
                          Text(
                            'Select Candidate for Auditing',
                            style: theme.typography.h4.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Click an applicant on the left to verify credentials.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStageTab(
    BuildContext context,
    String label,
    String stageVal,
    String activeStage,
    ValueChanged<String> onSelected,
  ) {
    final theme = context.theme;
    final isSelected = activeStage == stageVal;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) => onSelected(stageVal),
      selectedColor: theme.colors.primary.withValues(alpha: 0.15),
      backgroundColor: theme.colors.surface,
      labelStyle: theme.typography.labelBold.copyWith(
        color: isSelected ? theme.colors.primary : theme.colors.onSurfaceVariant,
      ),
    );
  }

  Widget _buildChecklistItem(
    BuildContext context,
    String label,
    String itemKey,
    Map<String, dynamic> applicant,
    HrOnboardingController controller,
  ) {
    final checklist = applicant['checklist'] as Map;
    final isChecked = checklist[itemKey] == true;
    final theme = context.theme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusSm),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
            ),
          ),
          Checkbox(
            value: isChecked,
            onChanged: (val) => controller.toggleChecklistItem((applicant['id'] as String), itemKey),
            activeColor: theme.colors.primary,
          ),
        ],
      ),
    );
  }
}
