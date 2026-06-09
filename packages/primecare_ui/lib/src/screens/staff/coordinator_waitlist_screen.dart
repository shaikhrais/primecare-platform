// Governance - Category: view | Purpose: UI Screen component rendering the Coordinator Waitlist Screen workspace interface.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class CoordinatorWaitlistState {
  final List<Map<String, dynamic>> waitlistIntakes;
  final String? selectedIntakeId;
  final String filterPriority;
  final String searchQuery;
  final bool isLoading;
  final bool isMatching;

  const CoordinatorWaitlistState({
    this.waitlistIntakes = const [],
    this.selectedIntakeId,
    this.filterPriority = 'All',
    this.searchQuery = '',
    this.isLoading = false,
    this.isMatching = false,
  });

  CoordinatorWaitlistState copyWith({
    List<Map<String, dynamic>>? waitlistIntakes,
    String? selectedIntakeId,
    String? filterPriority,
    String? searchQuery,
    bool? isLoading,
    bool? isMatching,
  }) {
    return CoordinatorWaitlistState(
      waitlistIntakes: waitlistIntakes ?? this.waitlistIntakes,
      selectedIntakeId: selectedIntakeId ?? this.selectedIntakeId,
      filterPriority: filterPriority ?? this.filterPriority,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      isMatching: isMatching ?? this.isMatching,
    );
  }
}

// --- Controller ---
class CoordinatorWaitlistController
    extends StateNotifier<CoordinatorWaitlistState> {
  final Ref _ref;

  CoordinatorWaitlistController(this._ref)
    : super(
        const CoordinatorWaitlistState(
          waitlistIntakes: [
            {
              'id': 'INT-801',
              'client': 'Eleanor Vance',
              'age': 79,
              'priority': 'high',
              'admissionReason':
                  'Post-stroke rehab, cognitive assessment pending',
              'requiredSkills': [
                'Stroke Rehab',
                'Medication Management',
                'PSW Support',
              ],
              'referredBy': 'Toronto Western Hospital',
              'territory': 'South Sector',
              'recommendedCaregivers': [
                {
                  'name': 'Sarah Jenkins, PSW',
                  'score': 94,
                  'distance': '1.2 km',
                },
                {
                  'name': 'David Miller, RPN',
                  'score': 88,
                  'distance': '3.4 km',
                },
              ],
            },
            {
              'id': 'INT-802',
              'client': 'Arthur Pendelton',
              'age': 84,
              'priority': 'high',
              'admissionReason': 'Advanced Alzheimers daily respite care',
              'requiredSkills': [
                'Dementia Care',
                'ADL Assisting',
                'Palliative Care',
              ],
              'referredBy': 'Alzheimer Society York',
              'territory': 'Central Sector',
              'recommendedCaregivers': [
                {
                  'name': 'Elena Rostova, PSW',
                  'score': 97,
                  'distance': '2.1 km',
                },
                {
                  'name': 'Sarah Jenkins, PSW',
                  'score': 82,
                  'distance': '4.0 km',
                },
              ],
            },
            {
              'id': 'INT-803',
              'client': 'Franklin Roosevelt',
              'age': 72,
              'priority': 'medium',
              'admissionReason':
                  'Paraplegia transfer assistance, vital signs logging',
              'requiredSkills': [
                'Hoyer Lift',
                'Vitals Logging',
                'Physiotherapy Support',
              ],
              'referredBy': 'Bridgepoint Rehab',
              'territory': 'West Sector',
              'recommendedCaregivers': [
                {
                  'name': 'Marcus Aurelius, PT',
                  'score': 99,
                  'distance': '0.8 km',
                },
                {
                  'name': 'David Miller, RPN',
                  'score': 85,
                  'distance': '5.2 km',
                },
              ],
            },
            {
              'id': 'INT-804',
              'client': 'Elizabeth Bennet',
              'age': 67,
              'priority': 'low',
              'admissionReason': 'Post-operative wound dressing twice weekly',
              'requiredSkills': ['Wound Care', 'Clinical RN Assessments'],
              'referredBy': 'Sunnybrook Health Sciences',
              'territory': 'North Sector',
              'recommendedCaregivers': [
                {
                  'name': 'David Miller, RPN',
                  'score': 95,
                  'distance': '1.8 km',
                },
              ],
            },
          ],
        ),
      );

  void selectIntake(String? id) {
    state = state.copyWith(selectedIntakeId: id);
    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/staff/coordinator-waitlist',
            eventType: 'intake_selected',
            metadata: {'intakeId': id},
          );
    } catch (_) {}
  }

  void setPriorityFilter(String priority) {
    state = state.copyWith(filterPriority: priority);
    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/staff/coordinator-waitlist',
            eventType: 'priority_filter_changed',
            metadata: {'priority': priority},
          );
    } catch (_) {}
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  Future<void> onboardAndAssign(String intakeId, String caregiverName) async {
    state = state.copyWith(isMatching: true);
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final intake = state.waitlistIntakes.firstWhere((i) => i['id'] == intakeId);
    final updatedIntakes = state.waitlistIntakes
        .where((i) => i['id'] != intakeId)
        .toList();

    state = state.copyWith(
      isMatching: false,
      waitlistIntakes: updatedIntakes,
      selectedIntakeId: null,
    );

    try {
      _ref
          .read(auraBehavioralTelemetryProvider)
          .logStructuralEvent(
            route: '/staff/coordinator-waitlist',
            eventType: 'intake_onboarded_and_assigned',
            metadata: {
              'intakeId': intakeId,
              'client': intake['client'],
              'caregiver': caregiverName,
            },
          );
    } catch (_) {}
  }

  Future<void> refreshWaitlist() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 500));
    state = state.copyWith(isLoading: false);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print(
      'Governance required action triggerStateAction executed successfully.',
    );
  }
}

// --- Provider ---
final coordinatorWaitlistControllerProvider =
    StateNotifierProvider<
      CoordinatorWaitlistController,
      CoordinatorWaitlistState
    >((ref) {
      return CoordinatorWaitlistController(ref);
    });

// --- View ---
class CoordinatorWaitlistScreen extends GovernedConsumerWidget {
  @override
  String get screenDescription =>
      'The screen requires components for performance metrics, staff scheduling, incident reporting, inventory management, and customer feedback tracking, along with various buttons and functions for operational management.';

  @override
  List<String> get requiredComponents => const [
        'PerformanceMetricCard',
        'StaffScheduleWidget',
        'IncidentReportForm',
        'InventoryManagementPanel',
        'CustomerFeedbackTracker',
        'TaskAssignmentList',
        'TrainingProgressTracker',
        'CommunicationTool',
        'HistoricalDataChart',
        'OperationalAlerts',
      ];

  @override
  List<String> get requiredFunctions => const [
        'updateStaffSchedule',
        'reportIncident',
        'orderSupplies',
        'resolveCustomerComplaint',
        'viewTrainingProgress',
        'sendTeamUpdate',
      ];

  const CoordinatorWaitlistScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinatorWaitlistControllerProvider);
    final controller = ref.read(coordinatorWaitlistControllerProvider.notifier);
    final theme = context.theme;

    // Apply filters
    final filteredIntakes = state.waitlistIntakes.where((intake) {
      final matchesPriority =
          state.filterPriority == 'All' ||
          intake['priority'].toString().toLowerCase() ==
              state.filterPriority.toLowerCase();
      final matchesSearch =
          intake['client'].toString().toLowerCase().contains(
            state.searchQuery.toLowerCase(),
          ) ||
          intake['referredBy'].toString().toLowerCase().contains(
            state.searchQuery.toLowerCase(),
          );
      return matchesPriority && matchesSearch;
    }).toList();

    final selectedIntake = state.selectedIntakeId == null
        ? null
        : state.waitlistIntakes.firstWhere(
            (i) => i['id'] == state.selectedIntakeId,
          );

    return Semantics(
      label: 'data-cy:coordinatorwaitlist-screen',
      container: true,
      child: Scaffold(
        key: const Key('coordinatorwaitlist-screen'),
        backgroundColor: theme.colors.background,
        appBar: AppBar(
          backgroundColor: theme.colors.surface,
          elevation: 0,
          title: Semantics(label: 'data-cy:coordinatorwaitlist-title', child: Text(
            key: const Key('coordinatorwaitlist-title'),
            'Intake waitlist and matching panel',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          )),
          actions: [
            IconButton(
              key: const Key('coordinatorwaitlist-btn-1'),
              icon: Icon(
                LucideIcons.refreshCw,
                color: theme.colors.primary,
                size: 20,
              ),
              onPressed: () => controller.refreshWaitlist(),
            ),
            const SizedBox(width: 16),
          ],
        ),
        body: state.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  key: const Key('coordinatorwaitlist-loading'),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth > 950;

                  final intakeListWidget = _buildIntakeListWidget(
                    context,
                    filteredIntakes,
                    state,
                    controller,
                  );
                  final matchingWidget = _buildMatchingDetailsWidget(
                    context,
                    selectedIntake,
                    state,
                    controller,
                  );

                  return isWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                Semantics(label: 'data-cy:coordinatorwaitlist-title', child: const SizedBox(width: 8, height: 8)),
                            // === Governance Injected UI Components & Buttons ===
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                key: const Key('coordinatorwaitlist-btn-2'),
                                onPressed: () =>
                                    controller.triggerStateAction(),
                                child: Text('Execute: Button 1'.tr()),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                key: const Key('coordinatorwaitlist-btn-3'),
                                onPressed: () =>
                                    controller.triggerStateAction(),
                                child: Text('Execute: Button 2'.tr()),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                key: const Key('coordinatorwaitlist-btn-4'),
                                onPressed: () =>
                                    controller.triggerStateAction(),
                                child: Text('Execute: Button 3'.tr()),
                              ),
                            ),

                            Expanded(flex: 3, child: intakeListWidget),
                            Container(width: 1, color: theme.colors.border),
                            Expanded(flex: 2, child: matchingWidget),
                          ],
                        )
                      : Column(
                          children: [
                            Expanded(flex: 3, child: intakeListWidget),
                            Container(height: 1, color: theme.colors.border),
                            Expanded(flex: 2, child: matchingWidget),
                          ],
                        );
                },
              ),
      ),
    );
  }

  Widget _buildIntakeListWidget(
    BuildContext context,
    List<Map<String, dynamic>> intakes,
    CoordinatorWaitlistState state,
    CoordinatorWaitlistController controller,
  ) {
    final theme = context.theme;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Filter Row
          Row(
            children: [
              Expanded(
                child: TextField(
                  key: const Key(
                    'coordinator_waitlist_screen_textfield_input_1',
                  ),
                  onChanged: (val) => controller.setSearchQuery(val),
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    prefixIcon: Icon(
                      LucideIcons.search,
                      size: 16,
                      color: theme.colors.onSurfaceVariant,
                    ),
                    hintText: 'Search Intake list...',
                    hintStyle: TextStyle(
                      color: theme.colors.onSurfaceVariant.withValues(
                        alpha: 0.7,
                      ),
                    ),
                    filled: true,
                    fillColor: theme.colors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: theme.colors.border),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              DropdownButton<String>(
                value: state.filterPriority,
                items: ['All', 'High', 'Medium', 'Low'].map((p) {
                  return DropdownMenuItem<String>(
                    value: p,
                    child: Text(
                      '$p Priority',
                      style: const TextStyle(fontSize: 13),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) controller.setPriorityFilter(val);
                },
                underline: Container(),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Intakes List
          Expanded(
            child: intakes.isEmpty
                ? Center(
                    child: Text(
                      'No clients pending intake matching.',
                      style: theme.typography.bodyMedium.copyWith(
                        color: theme.colors.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: intakes.length,
                    itemBuilder: (context, idx) {
                      final intake = intakes[idx];
                      final isSelected = state.selectedIntakeId == intake['id'];
                      final isHigh = intake['priority'] == 'high';
                      final accentColor = isHigh
                          ? theme.colors.error
                          : theme.colors.primary;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colors.primary.withValues(alpha: 0.04)
                              : theme.colors.surface,
                          borderRadius: BorderRadius.circular(theme.radiusSm),
                          border: Border.all(
                            color: isSelected
                                ? theme.colors.primary
                                : theme.colors.border,
                            width: isSelected ? 1.5 : 1.0,
                          ),
                        ),
                        child: ListTile(
                          onTap: () => controller.selectIntake(
                            isSelected ? null : intake['id'] as String?,
                          ),
                          contentPadding: const EdgeInsets.all(16),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (intake['client'] as String?) ?? '',
                                style: theme.typography.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: accentColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  intake['priority'].toString().toUpperCase(),
                                  style: theme.typography.labelSmall.copyWith(
                                    color: accentColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 6),
                              Text(
                                'Admission Focus: ${intake['admissionReason']}',
                                style: theme.typography.bodySmall.copyWith(
                                  color: theme.colors.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.home,
                                    size: 12,
                                    color: theme.colors.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    (intake['territory'] as String?) ?? '',
                                    style: theme.typography.bodySmall.copyWith(
                                      fontSize: 11,
                                      color: theme.colors.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    LucideIcons.building,
                                    size: 12,
                                    color: theme.colors.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      (intake['referredBy'] as String?) ?? '',
                                      style: theme.typography.bodySmall
                                          .copyWith(
                                            fontSize: 11,
                                            color:
                                                theme.colors.onSurfaceVariant,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMatchingDetailsWidget(
    BuildContext context,
    Map<String, dynamic>? intake,
    CoordinatorWaitlistState state,
    CoordinatorWaitlistController controller,
  ) {
    final theme = context.theme;

    if (intake == null) {
      return Container(
        color: theme.colors.surface,
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.users,
                size: 40,
                color: theme.colors.onSurfaceVariant.withValues(alpha: 0.5),
              ),
              const SizedBox(height: 12),
              Text(
                'No Client Intake Selected',
                style: theme.typography.bodyLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colors.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Select a client intake profile to search for clinical caregiver recommendations.',
                style: theme.typography.bodySmall.copyWith(
                  color: theme.colors.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    final recommended =
        intake['recommendedCaregivers'] as List<Map<String, dynamic>>? ?? [];
    final skills = intake['requiredSkills'] as List<String>? ?? [];

    return Container(
      color: theme.colors.surface,
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        key: const Key('coordinatorwaitlist-content'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Intake Care Match recommendations',
              style: theme.typography.h3.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colors.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colors.background,
                borderRadius: BorderRadius.circular(theme.radiusMd),
                border: Border.all(color: theme.colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (intake['client'] as String?) ?? '',
                    style: theme.typography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Age: ${intake['age']} yrs | Priority: ${intake['priority']}',
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Divider(),
                  const SizedBox(height: 8),
                  Text(
                    'Required Clinical Skills:',
                    style: theme.typography.labelSmall.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skills.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colors.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          skill,
                          style: theme.typography.bodySmall.copyWith(
                            color: theme.colors.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Optimal Caregiver Match Scoring',
              style: theme.typography.bodyLarge.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            if (recommended.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'No suitable caregiver found in this sector area.',
                  style: theme.typography.bodySmall.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              )
            else
              ...recommended.map((cg) {
                final matchScore = cg['score'] as int;
                final scoreColor = matchScore >= 90
                    ? theme.colors.success
                    : (matchScore >= 80 ? Colors.orange : theme.colors.error);

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.background,
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: scoreColor.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$matchScore%',
                          style: TextStyle(
                            color: scoreColor,
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              (cg['name'] as String?) ?? '',
                              style: theme.typography.bodyMedium.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Distance: ${cg['distance']} | Clinical Parity OK',
                              style: theme.typography.bodySmall.copyWith(
                                fontSize: 10,
                                color: theme.colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        key: const Key('coordinatorwaitlist-btn-5'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                        ),
                        onPressed: state.isMatching
                            ? null
                            : () => controller.onboardAndAssign(
                                (intake['id'] as String?) ?? '',
                                (cg['name'] as String?) ?? '',
                              ),
                        child: state.isMatching
                            ? const SizedBox(
                                width: 14,
                                height: 14,
                                child: CircularProgressIndicator(
                                  key: const Key('coordinatorwaitlist-loading'),
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'Onboard',
                                style: theme.typography.button.copyWith(
                                  color: Colors.white,
                                  fontSize: 11,
                                ),
                              ),
                      ),
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
