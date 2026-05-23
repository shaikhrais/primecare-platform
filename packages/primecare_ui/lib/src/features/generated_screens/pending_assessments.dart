// Governance - Category: service | Purpose: --- MVC State Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PendingAssessmentsState {
  final List<Map<String, dynamic>> assessments;
  final String searchQuery;
  final String selectedPriorityFilter;
  final bool isMutatingState;

  const PendingAssessmentsState({
    required this.assessments,
    required this.searchQuery,
    required this.selectedPriorityFilter,
    required this.isMutatingState,
  });

  PendingAssessmentsState copyWith({
    List<Map<String, dynamic>>? assessments,
    String? searchQuery,
    String? selectedPriorityFilter,
    bool? isMutatingState,
  }) {
    return PendingAssessmentsState(
      assessments: assessments ?? this.assessments,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedPriorityFilter: selectedPriorityFilter ?? this.selectedPriorityFilter,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class PendingAssessmentsController extends StateNotifier<PendingAssessmentsState> {
  final Ref _ref;

  PendingAssessmentsController(this._ref)
      : super(
          const PendingAssessmentsState(
            assessments: [
              {
                'id': 'asm-001',
                'client': 'Eleanor Vance',
                'type': 'Cognitive Screening',
                'priority': 'High',
                'dueDate': '2026-05-22',
                'clinician': 'Sarah Jenkins (RN)',
                'status': 'Pending',
              },
              {
                'id': 'asm-002',
                'client': 'Arthur Pendelton',
                'type': 'ADL Intake Assessment',
                'priority': 'High',
                'dueDate': '2026-05-23',
                'clinician': '',
                'status': 'Pending',
              },
              {
                'id': 'asm-003',
                'client': 'Clara Higgins',
                'type': 'Physical Mobility Check',
                'priority': 'Medium',
                'dueDate': '2026-05-25',
                'clinician': 'David Miller (RPN)',
                'status': 'Scheduled',
              },
              {
                'id': 'asm-004',
                'client': 'Robert Vance',
                'type': 'Post-Op Follow-up',
                'priority': 'Low',
                'dueDate': '2026-05-28',
                'clinician': '',
                'status': 'Pending',
              },
            ],
            searchQuery: '',
            selectedPriorityFilter: 'All',
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updatePriorityFilter(String filter) {
    state = state.copyWith(selectedPriorityFilter: filter);
  }

  void scheduleAssessment({
    required String id,
    required String clinician,
    required String date,
  }) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/pending_assessments',
            eventType: 'clinical_assessment_scheduled',
            metadata: {
              'assessmentId': id,
              'clinician': clinician,
              'date': date,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.assessments.map((a) {
        if (a['id'] == id) {
          return {
            ...a,
            'clinician': clinician,
            'dueDate': date,
            'status': 'Scheduled',
          };
        }
        return a;
      }).toList();

      state = state.copyWith(
        assessments: updated,
        isMutatingState: false,
      );
    });
  }

  void completeAssessment(String id) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/pending_assessments',
            eventType: 'assessment_completed',
            metadata: {'assessmentId': id},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.assessments.map((a) {
        if (a['id'] == id) {
          return {
            ...a,
            'status': 'Completed',
          };
        }
        return a;
      }).toList();

      state = state.copyWith(
        assessments: updated,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final pendingAssessmentsControllerProvider =
    StateNotifierProvider<PendingAssessmentsController, PendingAssessmentsState>((ref) {
  return PendingAssessmentsController(ref);
});

// --- View ---
class PendingAssessments extends GovernedConsumerWidget {
  const PendingAssessments({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pendingAssessmentsControllerProvider);
    final controller = ref.read(pendingAssessmentsControllerProvider.notifier);
    final theme = context.theme;

    // Filter assessments
    final filtered = state.assessments.where((a) {
      final matchesSearch = (a['client'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (a['type'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesPriority = state.selectedPriorityFilter == 'All' ||
          (a['priority'] as String).toLowerCase() == state.selectedPriorityFilter.toLowerCase();
      return matchesSearch && matchesPriority;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.clipboardCheck, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Pending Clinical Assessments',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Intake Assessments Queue',
                  style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 4),
                Text(
                  'Assign nurses and coordinate comprehensive physical and cognitive screenings for referred clients.',
                  style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                ),
                const SizedBox(height: 24),

                // Search & Filter Row
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by client or assessment type...',
                            prefixIcon: const Icon(LucideIcons.search, size: 20),
                            fillColor: theme.colors.background,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              borderSide: BorderSide(color: theme.colors.border),
                            ),
                          ),
                          onChanged: controller.updateSearch,
                        ),
                      ),
                      const SizedBox(width: 16),
                      DropdownButton<String>(
                        value: state.selectedPriorityFilter,
                        onChanged: (val) {
                          if (val != null) controller.updatePriorityFilter(val);
                        },
                        items: const [
                          DropdownMenuItem(value: 'All', child: Text('All Priorities')),
                          DropdownMenuItem(value: 'High', child: Text('High Priority')),
                          DropdownMenuItem(value: 'Medium', child: Text('Medium Priority')),
                          DropdownMenuItem(value: 'Low', child: Text('Low Priority')),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Queue List
                Expanded(
                  child: filtered.isEmpty
                      ? Center(
                          child: Text(
                            'No pending assessments matching filters.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final item = filtered[index];
                            final isPending = item['status'] == 'Pending';
                            final isCompleted = item['status'] == 'Completed';
                            final priorityColor = item['priority'] == 'High'
                                ? Colors.red
                                : item['priority'] == 'Medium'
                                    ? Colors.amber
                                    : Colors.blue;

                            return Card(
                              margin: const EdgeInsets.only(bottom: 16),
                              color: theme.colors.surface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                side: BorderSide(color: theme.colors.border),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                (item['client'] as String),
                                                style: theme.typography.h4.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color: theme.colors.onSurface,
                                                ),
                                              ),
                                              const SizedBox(width: 12),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: priorityColor.withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  (item['priority'] as String).toUpperCase(),
                                                  style: TextStyle(
                                                    color: priorityColor,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                                decoration: BoxDecoration(
                                                  color: isCompleted
                                                      ? Colors.green.withValues(alpha: 0.1)
                                                      : isPending
                                                          ? Colors.orange.withValues(alpha: 0.1)
                                                          : Colors.blue.withValues(alpha: 0.1),
                                                  borderRadius: BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  (item['status'] as String).toUpperCase(),
                                                  style: TextStyle(
                                                    color: isCompleted
                                                        ? Colors.green
                                                        : isPending
                                                            ? Colors.orange
                                                            : Colors.blue,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Type: ${item['type']}',
                                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurface),
                                          ),
                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(LucideIcons.calendar, size: 14, color: theme.colors.onSurfaceVariant),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Due Date: ${item['dueDate']}',
                                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                              ),
                                              const SizedBox(width: 16),
                                              Icon(LucideIcons.user, size: 14, color: theme.colors.onSurfaceVariant),
                                              const SizedBox(width: 4),
                                              Text(
                                                item['clinician'].toString().isEmpty
                                                    ? 'Unassigned'
                                                    : 'Clinician: ${item['clinician']}',
                                                style: theme.typography.bodySmall.copyWith(
                                                  color: item['clinician'].toString().isEmpty
                                                      ? Colors.orange
                                                      : theme.colors.onSurfaceVariant,
                                                  fontWeight: item['clinician'].toString().isEmpty
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (!isCompleted) ...[
                                      const SizedBox(width: 16),
                                      Row(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () => _showScheduleModal(context, controller, (item['id'] as String)),
                                            icon: const Icon(LucideIcons.calendar),
                                            label: Text(isPending ? 'Assign' : 'Reschedule'),
                                          ),
                                          if (!isPending) ...[
                                            const SizedBox(width: 8),
                                            ElevatedButton(
                                              onPressed: () => controller.completeAssessment((item['id'] as String)),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: theme.colors.primary,
                                                foregroundColor: Colors.white,
                                              ),
                                              child: const Text('Complete'),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
          if (state.isMutatingState)
            Container(
              color: Colors.black.withValues(alpha: 0.15),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  void _showScheduleModal(BuildContext context, PendingAssessmentsController controller, String id) {
    final theme = context.theme;
    String selectedClinician = 'Sarah Jenkins (RN)';
    String dateStr = '2026-05-24';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colors.surface,
          title: Text(
            'Schedule Assessment Intake',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedClinician,
                items: const [
                  DropdownMenuItem(value: 'Sarah Jenkins (RN)', child: Text('Sarah Jenkins (RN)')),
                  DropdownMenuItem(value: 'David Miller (RPN)', child: Text('David Miller (RPN)')),
                  DropdownMenuItem(value: 'Dr. Aris (Clinical Lead)', child: Text('Dr. Aris (Clinical Lead)')),
                ],
                onChanged: (val) {
                  if (val != null) selectedClinician = val;
                },
                decoration: InputDecoration(
                  labelText: 'Assign Nurse/Clinician',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Schedule Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
                controller: TextEditingController(text: dateStr),
                onChanged: (val) => dateStr = val,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: theme.colors.onSurfaceVariant)),
            ),
            ElevatedButton(
              onPressed: () {
                controller.scheduleAssessment(id: id, clinician: selectedClinician, date: dateStr);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
