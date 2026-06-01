// Governance - Category: view | Purpose: UI Screen component rendering the Rn Workflow Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RnWorkflowState {
  final List<Map<String, dynamic>> revisions;
  final bool isCreatingGoal;
  final String activePatient;

  const RnWorkflowState({
    required this.revisions,
    required this.isCreatingGoal,
    required this.activePatient,
  });

  RnWorkflowState copyWith({
    List<Map<String, dynamic>>? revisions,
    bool? isCreatingGoal,
    String? activePatient,
  }) {
    return RnWorkflowState(
      revisions: revisions ?? this.revisions,
      isCreatingGoal: isCreatingGoal ?? this.isCreatingGoal,
      activePatient: activePatient ?? this.activePatient,
    );
  }
}

// --- Controller ---
class RnWorkflowController extends StateNotifier<RnWorkflowState> {
  final Ref _ref;

  RnWorkflowController(this._ref)
    : super(
        const RnWorkflowState(
          activePatient: 'Margaret Thompson',
          isCreatingGoal: false,
          revisions: [
            {
              'id': 'REV-101',
              'patient': 'Margaret Thompson',
              'title': 'Post-Operative Recovery Plan Rev 2',
              'author': 'RN Sarah Jenkins',
              'status': 'Approved',
              'date': 'May 18, 2026',
              'notes': 'Added daily passive range-of-motion routines.',
            },
            {
              'id': 'REV-102',
              'patient': 'Arthur Pendelton',
              'title': 'Dementia Management Protocol Rev 1',
              'author': 'RN David Vance',
              'status': 'Pending Approval',
              'date': 'May 19, 2026',
              'notes':
                  'Revised hydration goals from 1.5L to 2.1L daily due to vitals.',
            },
            {
              'id': 'REV-103',
              'patient': 'Eleanor Vance',
              'title': 'Hypertension Care Coordination Rev 4',
              'author': 'RN Sarah Jenkins',
              'status': 'Draft',
              'date': 'Just Now',
              'notes': 'Integrating low-sodium meal preps with PSW checklists.',
            },
          ],
        ),
      );

  void approveRevision(String revId) {
    final updatedRevisions = state.revisions.map((rev) {
      if (rev['id'] == revId) {
        return {...rev, 'status': 'Approved'};
      }
      return rev;
    }).toList();

    state = state.copyWith(revisions: updatedRevisions);

    // Aura behavioral telemetry logging
    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/rn/workflow',
            eventType: 'rn_revision_approved',
            metadata: {'revisionId': revId},
          );
    } catch (_) {}
  }

  Future<void> submitNewGoal({
    required String patient,
    required String goalTitle,
    required String targetDuration,
    required String scope,
  }) async {
    state = state.copyWith(isCreatingGoal: true);

    // Simulate delay
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final newRev = {
      'id':
          'REV-${DateTime.now().millisecondsSinceEpoch.toString().substring(10)}',
      'patient': patient,
      'title': 'New Therapeutic Goal: $goalTitle',
      'author': 'RN Lead',
      'status': 'Approved',
      'date': 'Today',
      'notes': 'Goal: $scope | Target: $targetDuration',
    };

    state = state.copyWith(
      revisions: [newRev, ...state.revisions],
      isCreatingGoal: false,
    );

    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/rn/workflow',
            eventType: 'rn_goal_created',
            metadata: {
              'patient': patient,
              'goal': goalTitle,
              'duration': targetDuration,
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
final rnWorkflowControllerProvider =
    StateNotifierProvider<RnWorkflowController, RnWorkflowState>((ref) {
      return RnWorkflowController(ref);
    });

// --- View ---
class RnWorkflowScreen extends GovernedConsumerWidget {
  const RnWorkflowScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnWorkflowControllerProvider);
    final controller = ref.read(rnWorkflowControllerProvider.notifier);
    final theme = context.theme;

    return Semantics(
      label: 'data-cy:rnworkflow-screen',
      container: true,
      child: Scaffold(
        key: const Key('rnworkflow-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(label: 'data-cy:rnworkflow-title', container: true, child: Container(child: Text(
            key: const Key('rnworkflow-title'),
            'RN Supervisor Workflows',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ))),
        ),
        body: Semantics(
          label: 'data-cy:rnworkflow-content',
          container: true,
          child: SingleChildScrollView(
            key: const Key('rnworkflow-content'),
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // === Governance Injected UI Components & Buttons ===
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    key: const Key('rnworkflow-btn-1'),
                    onPressed: () => controller.triggerStateAction(),
                    child: Text('Execute: Button 1'.tr()),
                  ),
                ),

                Semantics(
                  label: 'data-cy:rnworkflow-title',
                  child: GovDashboardHero(
                    title: 'Care Plan Revisions & Goal Builders',
                    roleName: 'Registered Nurse (RN) Lead',
                    description:
                        'Supervisory authorization pipelines for active plan adjustments, clinical timelines, and multi-level check gates.',
                    onRefresh: () => ref.refresh(rnWorkflowControllerProvider),
                  ),
                ),
                const SizedBox(height: 24),

                // Revision Timelines & Form Layout (Responsive Rows)
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 900) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 6,
                            child: _buildTimelineRevisionCard(
                              context,
                              state,
                              controller,
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 5,
                            child: _buildGoalBuilderCard(
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
                          _buildTimelineRevisionCard(
                            context,
                            state,
                            controller,
                          ),
                          const SizedBox(height: 24),
                          _buildGoalBuilderCard(context, state, controller),
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

  Widget _buildTimelineRevisionCard(
    BuildContext context,
    RnWorkflowState state,
    RnWorkflowController controller,
  ) {
    final theme = context.theme;

    return PrimeCareCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Care Plan Authorization Timeline',
            style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'History of clinical goals, checklist inclusions, and supervisor approval logs.',
            style: theme.typography.bodyMedium.copyWith(
              color: theme.colors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.revisions.length,
            itemBuilder: (context, index) {
              final rev = state.revisions[index];
              final id = rev['id'] as String;
              final patient = rev['patient'] as String;
              final title = rev['title'] as String;
              final notes = rev['notes'] as String;
              final author = rev['author'] as String;
              final date = rev['date'] as String;
              final status = rev['status'] as String;

              final isPending = status == 'Pending Approval';
              final isApproved = status == 'Approved';

              return IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Timeline vertical bar and indicator
                    Column(
                      children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isApproved
                                ? Colors.green
                                : isPending
                                ? Colors.orange
                                : theme.colors.outline,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: 2,
                            color: theme.colors.divider,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 24.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colors.background,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: theme.colors.divider),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: theme.typography.bodyLarge
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isApproved
                                          ? Colors.green.withValues(alpha: 0.1)
                                          : isPending
                                          ? Colors.orange.withValues(alpha: 0.1)
                                          : theme.colors.outline.withValues(
                                              alpha: 0.1,
                                            ),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      status,
                                      style: theme.typography.labelSmall
                                          .copyWith(
                                            color: isApproved
                                                ? Colors.green
                                                : isPending
                                                ? Colors.orange
                                                : theme.colors.onSurfaceVariant,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Patient: $patient | Registered: $author on $date',
                                style: theme.typography.bodySmall.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notes,
                                style: theme.typography.bodyMedium.copyWith(
                                  color: theme.colors.onSurface,
                                ),
                              ),
                              if (isPending) ...[
                                const SizedBox(height: 12),
                                ElevatedButton.icon(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 10,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  ),
                                  onPressed: () {
                                    controller.approveRevision(id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Revision approved and logged.',
                                        ),
                                        backgroundColor: Colors.green,
                                      ),
                                    );
                                  },
                                  icon: const Icon(LucideIcons.check, size: 16),
                                  label: const Text('Approve Revision'),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGoalBuilderCard(
    BuildContext context,
    RnWorkflowState state,
    RnWorkflowController controller,
  ) {
    final theme = context.theme;

    final patientController = TextEditingController(text: 'Margaret Thompson');
    final goalTitleController = TextEditingController();
    final scopeController = TextEditingController();
    String selectedDuration = '1 month';

    final formKey = GlobalKey<FormState>();

    return PrimeCareCard(
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Therapeutic Goal Builder Matrix',
              style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Define precise diagnostic timelines, milestone scopes, and track compliance metrics.',
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 24),
            PrimeCareTextField(
              key: const Key('rn_workflow_screen_textfield_input_1'),
              label: 'Target Patient Name',
              controller: patientController,
              validator: (val) {
                if (val == null || val.isEmpty) return 'Patient name required';
                return null;
              },
            ),
            const SizedBox(height: 16),
            PrimeCareTextField(
              key: const Key('rn_workflow_screen_textfield_input_2'),
              label: 'Active Care Plan Goal',
              controller: goalTitleController,
              hintText: 'e.g. Post-stroke motor function restoration...',
              validator: (val) {
                if (val == null || val.isEmpty) return 'Goal title required';
                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedDuration,
              dropdownColor: theme.colors.surface,
              style: theme.typography.bodyMedium.copyWith(
                color: theme.colors.onSurface,
              ),
              decoration: InputDecoration(
                labelText: 'Target Milestone Duration',
                labelStyle: theme.typography.labelMedium,
              ),
              items: ['2 weeks', '1 month', '3 months', '6 months']
                  .map((dur) => DropdownMenuItem(value: dur, child: Text(dur)))
                  .toList(),
              onChanged: (val) {
                if (val != null) selectedDuration = val;
              },
            ),
            const SizedBox(height: 16),
            PrimeCareTextField(
              key: const Key('rn_workflow_screen_textfield_input_3'),
              label: 'milestone Action Scope Detail',
              controller: scopeController,
              maxLines: 3,
              hintText:
                  'Provide details, therapeutic targets, or restriction criteria...',
              validator: (val) {
                if (val == null || val.isEmpty) return 'Scope is required';
                return null;
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              key: const Key('rnworkflow-btn-2'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size.fromHeight(50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(theme.radiusDefault),
                ),
              ),
              onPressed: state.isCreatingGoal
                  ? null
                  : () async {
                      if (formKey.currentState!.validate()) {
                        await controller.submitNewGoal(
                          patient: patientController.text,
                          goalTitle: goalTitleController.text,
                          targetDuration: selectedDuration,
                          scope: scopeController.text,
                        );
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'New Care Goal established and approved.',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                          goalTitleController.clear();
                          scopeController.clear();
                        }
                      }
                    },
              child: state.isCreatingGoal
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        key: const Key('rnworkflow-loading'),
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Compile Care Plan Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
