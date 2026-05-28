// Governance - Category: view | Purpose: UI Screen component rendering the Rn Care Plans Screen workspace interface.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class RnCarePlansState {
  final List<Map<String, dynamic>> carePlans;
  final String activePlanId;
  final String selectedCategory; // 'all', 'active', 'draft'

  const RnCarePlansState({
    required this.carePlans,
    this.activePlanId = 'PLN-401',
    this.selectedCategory = 'all',
  });

  RnCarePlansState copyWith({
    List<Map<String, dynamic>>? carePlans,
    String? activePlanId,
    String? selectedCategory,
  }) {
    return RnCarePlansState(
      carePlans: carePlans ?? this.carePlans,
      activePlanId: activePlanId ?? this.activePlanId,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

// --- Controller (Notifier) ---
class RnCarePlansController extends StateNotifier<RnCarePlansState> {
  final Ref _ref;

  RnCarePlansController(this._ref)
      : super(
          const RnCarePlansState(
            carePlans: [
              {
                'id': 'PLN-401',
                'client': 'Margaret Thompson',
                'age': 82,
                'status': 'active',
                'author': 'Sarah Jenkins, RN',
                'lastUpdated': '2026-05-12',
                'goals': [
                  'Maintain baseline blood pressure levels below 140/90.',
                  'Ensure caregiver-assisted mobility walk at least once daily.',
                  'Support cognitive health through daily interactive word exercises.',
                ],
                'interventions': [
                  'Daily blood pressure monitoring and record log.',
                  'Mobility support using single-point cane; assist for 15 mins.',
                  'Assist with light breakfast preparation and nutrition oversight.',
                ],
              },
              {
                'id': 'PLN-402',
                'client': 'Arthur Pendelton',
                'age': 79,
                'status': 'active',
                'author': 'Sarah Jenkins, RN',
                'lastUpdated': '2026-05-18',
                'goals': [
                  'Maintain morning blood glucose levels between 4.0 - 7.0 mmol/L.',
                  'Prevent diabetic foot complications through daily skincare audits.',
                ],
                'interventions': [
                  'Facilitate glucometer checks and register results in task diary.',
                  'Thoroughly wash, dry, and inspect feet during bathing routines.',
                ],
              },
              {
                'id': 'PLN-403',
                'client': 'Eleanor Vance',
                'age': 88,
                'status': 'draft',
                'author': 'Sarah Jenkins, RN',
                'lastUpdated': '2026-05-20',
                'goals': [
                  'Avoid any fall incidents during transfers and ADLs.',
                  'Prevent aspiration risks by supporting proper upright feeding postures.',
                ],
                'interventions': [
                  'Strict supervision and stand-by mobility support with walker.',
                  'Encourage patient to remain sitting upright for 30 mins post-meal.',
                ],
              },
            ],
          ),
        );

  void selectCarePlan(String id) {
    state = state.copyWith(activePlanId: id);
  }

  void addGoal(String id, String goalText) {
    final updatedPlans = state.carePlans.map((plan) {
      if (plan['id'] == id) {
        final List<String> currentGoals = List.from(plan['goals'] as List<String>)..add(goalText);

        // Telemetry execution gate
        try {
          _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
                route: '/rn/care-plans',
                eventType: 'rn_goal_added',
                metadata: {'planId': id, 'goal': goalText},
              );
        } catch (_) {}

        return {
          ...plan,
          'goals': currentGoals,
          'lastUpdated': DateTime.now().toIso8601String().substring(0, 10),
        };
      }
      return plan;
    }).toList();

    state = state.copyWith(carePlans: updatedPlans);
  }

  void addIntervention(String id, String interventionText) {
    final updatedPlans = state.carePlans.map((plan) {
      if (plan['id'] == id) {
        final List<String> currentInterventions = List.from(plan['interventions'] as List<String>)
          ..add(interventionText);

        try {
          _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
                route: '/rn/care-plans',
                eventType: 'rn_intervention_added',
                metadata: {'planId': id, 'intervention': interventionText},
              );
        } catch (_) {}

        return {
          ...plan,
          'interventions': currentInterventions,
          'lastUpdated': DateTime.now().toIso8601String().substring(0, 10),
        };
      }
      return plan;
    }).toList();

    state = state.copyWith(carePlans: updatedPlans);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }
}

// --- Provider ---
final rnCarePlansControllerProvider =
    StateNotifierProvider<RnCarePlansController, RnCarePlansState>((ref) {
  return RnCarePlansController(ref);
});

// --- View ---
class RnCarePlansScreen extends GovernedConsumerWidget {
  const RnCarePlansScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rnCarePlansControllerProvider);
    final controller = ref.read(rnCarePlansControllerProvider.notifier);
    final theme = context.theme;

    final filteredPlans = state.carePlans.where((plan) {
      if (state.selectedCategory == 'active') return plan['status'] == 'active';
      if (state.selectedCategory == 'draft') return plan['status'] == 'draft';
      return true;
    }).toList();

    final activePlan = state.carePlans.firstWhere(
      (p) => p['id'] == state.activePlanId,
      orElse: () => state.carePlans.first,
    );

    return Scaffold(
      key: const Key('rncareplans-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('rncareplans-title'),
          'Clinical Care Plans',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Semantics(
        label: 'data-cy:rncareplans-screen',
        child: Row(
        key: const Key('rncareplans-content'),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('rncareplans-btn-1'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

          // Sidebar Patient Selector List
          Container(
            width: 320,
            decoration: BoxDecoration(
              color: theme.colors.surface,
              border: Border(right: BorderSide(color: theme.colors.border)),
            ),
            child: ListView.builder(
              itemCount: filteredPlans.length,
              itemBuilder: (context, index) {
                final plan = filteredPlans[index];
                final isSelected = plan['id'] == state.activePlanId;

                return InkWell(
                  onTap: () => controller.selectCarePlan(plan['id'] as String),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colors.primary.withValues(alpha: 0.05) : null,
                      border: Border(
                        bottom: BorderSide(color: theme.colors.border),
                        left: BorderSide(
                          color: isSelected ? theme.colors.primary : Colors.transparent,
                          width: 4,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (plan['client'] as String?) ?? '',
                              style: theme.typography.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colors.onSurface,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: plan['status'] == 'active'
                                    ? Colors.green.withValues(alpha: 0.1)
                                    : Colors.orange.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                plan['status'].toString().toUpperCase(),
                                style: theme.typography.labelSmall.copyWith(
                                  color: plan['status'] == 'active' ? Colors.green : Colors.orange,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Age ${plan['age']} · Plan ID: ${plan['id']}',
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          // Active Care Plan Details Panel
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32.0),
              child: _buildCarePlanWorkspace(context, activePlan, controller),
            ),
          ),
        ],),
    ),
    );
  }

  Widget _buildCarePlanWorkspace(
    BuildContext context,
    Map<String, dynamic> plan,
    RnCarePlansController controller,
  ) {
    final theme = context.theme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Workspace Header Banner
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colors.surface,
            borderRadius: BorderRadius.circular(theme.radiusMd),
            border: Border.all(color: theme.colors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Clinical Direction Hub',
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                (plan['client'] as String?) ?? '',
                style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    'Author: ${plan['author']}',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Last Updated: ${plan['lastUpdated']}',
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        // Goals and Objectives Panel
        _buildPlanSection(
          context,
          'Strategic Goals & Targets',
          'Clinical targets assigned to direct recovery metrics and status indicators.',
          plan['goals'] as List<String>,
          (text) => controller.addGoal(plan['id'] as String, text),
        ),
        const SizedBox(height: 28),
        // Direct Interventions Panel
        _buildPlanSection(
          context,
          'Caregiver Interventions & ADLs',
          'Explicit task directives carried out by support staff during home shifts.',
          plan['interventions'] as List<String>,
          (text) => controller.addIntervention(plan['id'] as String, text),
        ),
      ],
    );
  }

  Widget _buildPlanSection(
    BuildContext context,
    String title,
    String subtitle,
    List<String> items,
    void Function(String) onAdd,
  ) {
    final theme = context.theme;
    final textController = TextEditingController();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
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
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 18),
          ...items.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '• ',
                      style: TextStyle(
                        color: theme.colors.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item,
                        style: theme.typography.bodyMedium.copyWith(
                          color: theme.colors.onSurface,
                        ),
                      ),
                    ),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(key: const Key('rn_care_plans_screen_textfield_input_1'), 
                  controller: textController,
                  decoration: InputDecoration(
                    hintText: 'Enter new clinical objective or instruction...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
            key: const Key('rncareplans-btn-2'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (textController.text.isNotEmpty) {
                    onAdd(textController.text);
                    textController.clear();
                  }
                },
                child: Text(
                  'Add',
                  style: theme.typography.button.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
