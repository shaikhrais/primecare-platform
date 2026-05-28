// Governance - Category: service | Purpose: Core implementation file for the Intake Pipeline platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class IntakePipelineState {
  final List<Map<String, dynamic>> intakes;
  final String searchQuery;
  final String selectedUrgencyFilter;
  final bool isCreatingIntake;
  final bool isMutatingState;

  const IntakePipelineState({
    required this.intakes,
    required this.searchQuery,
    required this.selectedUrgencyFilter,
    required this.isCreatingIntake,
    required this.isMutatingState,
  });

  IntakePipelineState copyWith({
    List<Map<String, dynamic>>? intakes,
    String? searchQuery,
    String? selectedUrgencyFilter,
    bool? isCreatingIntake,
    bool? isMutatingState,
  }) {
    return IntakePipelineState(
      intakes: intakes ?? this.intakes,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedUrgencyFilter: selectedUrgencyFilter ?? this.selectedUrgencyFilter,
      isCreatingIntake: isCreatingIntake ?? this.isCreatingIntake,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class IntakePipelineController extends StateNotifier<IntakePipelineState> {
  final Ref _ref;

  IntakePipelineController(this._ref)
      : super(
          const IntakePipelineState(
            intakes: [
              {
                'id': 'int-101',
                'name': 'James Anderson',
                'stage': 'Referral Received',
                'source': 'Toronto General Hospital',
                'urgency': 'high',
                'date': '2025-05-18',
                'nurse': '',
              },
              {
                'id': 'int-102',
                'name': 'Emily Watson',
                'stage': 'Initial Contact',
                'source': 'Family Inquiry',
                'urgency': 'medium',
                'date': '2025-05-19',
                'nurse': '',
              },
              {
                'id': 'int-103',
                'name': 'Michael Chang',
                'stage': 'Assessment Scheduled',
                'source': 'Dr. Aris (Physician Referral)',
                'urgency': 'high',
                'date': '2025-05-17',
                'nurse': 'Sarah Jenkins (PSW)',
              },
              {
                'id': 'int-104',
                'name': 'Eleanor Vance',
                'stage': 'Approved',
                'source': 'Corporate Health Network',
                'urgency': 'low',
                'date': '2025-05-15',
                'nurse': 'David Miller (RPN)',
              },
            ],
            searchQuery: '',
            selectedUrgencyFilter: 'all',
            isCreatingIntake: false,
            isMutatingState: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateUrgencyFilter(String filter) {
    state = state.copyWith(selectedUrgencyFilter: filter);
  }

  void advanceStage(String intakeId) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/offices/clinical/roles/intake_coordinator/dashboard',
            eventType: 'intake_stage_advanced',
            metadata: {'intakeId': intakeId},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.intakes.map((i) {
        if (i['id'] == intakeId) {
          final nextStage = _getNextStage(i['stage'] as String);
          return {...i, 'stage': nextStage};
        }
        return i;
      }).toList();

      state = state.copyWith(
        intakes: updated,
        isMutatingState: false,
      );
    });
  }

  void scheduleAssessment(String intakeId, String nurseName, String dateStr) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/offices/clinical/roles/intake_coordinator/dashboard',
            eventType: 'clinical_assessment_scheduled',
            metadata: {
              'intakeId': intakeId,
              'nurse': nurseName,
              'date': dateStr,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 300), () {
      final updated = state.intakes.map((i) {
        if (i['id'] == intakeId) {
          return {
            ...i,
            'stage': 'Assessment Scheduled',
            'nurse': nurseName,
            'date': dateStr,
          };
        }
        return i;
      }).toList();

      state = state.copyWith(
        intakes: updated,
        isMutatingState: false,
      );
    });
  }

  void createIntake({
    required String name,
    required String source,
    required String urgency,
  }) {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/offices/clinical/roles/intake_coordinator/dashboard',
            eventType: 'intake_referral_created',
            metadata: {
              'name': name,
              'source': source,
              'urgency': urgency,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final nextIntake = {
        'id': 'int-${DateTime.now().millisecondsSinceEpoch}',
        'name': name,
        'stage': 'Referral Received',
        'source': source,
        'urgency': urgency,
        'date': DateTime.now().toString().substring(0, 10),
        'nurse': '',
      };

      state = state.copyWith(
        intakes: [nextIntake, ...state.intakes],
        isCreatingIntake: false,
        isMutatingState: false,
      );
    });
  }

  void toggleCreateDrawer(bool open) {
    state = state.copyWith(isCreatingIntake: open);
  }

  String _getNextStage(String currentStage) {
    switch (currentStage) {
      case 'Referral Received':
        return 'Initial Contact';
      case 'Initial Contact':
        return 'Assessment Scheduled';
      case 'Assessment Scheduled':
        return 'Approved';
      default:
        return 'Approved';
    }
  }
}

// --- Provider ---
final intakePipelineControllerProvider =
    StateNotifierProvider<IntakePipelineController, IntakePipelineState>((ref) {
  return IntakePipelineController(ref);
});

// --- View ---
class IntakePipeline extends GovernedConsumerWidget {
  const IntakePipeline({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(intakePipelineControllerProvider);
    final controller = ref.read(intakePipelineControllerProvider.notifier);
    final theme = context.theme;

    // Filter intakes
    final filtered = state.intakes.where((i) {
      final matchesSearch = (i['name'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (i['source'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesUrgency = state.selectedUrgencyFilter == 'all' ||
          (i['urgency'] as String).toLowerCase() == state.selectedUrgencyFilter.toLowerCase();
      return matchesSearch && matchesUrgency;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.gitCommit, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Intake Coordinator Pipeline Command',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          IconButton(key: const Key('intake_pipeline_iconbutton_button_1'), 
            icon: Icon(LucideIcons.plusCircle, color: theme.colors.primary),
            onPressed: () => controller.toggleCreateDrawer(true),
            tooltip: 'Add New Referral',
          )
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Filters
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Onboarding & Referral Funnel',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Track patient transition stages from incoming physician leads to final service authorization.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Search & Filter Box
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
                        flex: 3,
                        child: TextField(key: const Key('intake_pipeline_textfield_input_1'), 
                          decoration: InputDecoration(
                            hintText: 'Search pipeline referrals...',
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
                      Wrap(
                        spacing: 8,
                        children: [
                          _UrgencyTab(
                            label: 'All Urgencies',
                            value: 'all',
                            activeFilter: state.selectedUrgencyFilter,
                            onTap: controller.updateUrgencyFilter,
                          ),
                          _UrgencyTab(
                            label: 'High Urgency',
                            value: 'high',
                            activeFilter: state.selectedUrgencyFilter,
                            onTap: controller.updateUrgencyFilter,
                          ),
                          _UrgencyTab(
                            label: 'Medium Urgency',
                            value: 'medium',
                            activeFilter: state.selectedUrgencyFilter,
                            onTap: controller.updateUrgencyFilter,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Kanban Grid Channels
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _KanbanColumn(
                        title: 'Referral Received',
                        color: Colors.blue,
                        intakes: filtered.where((i) => i['stage'] == 'Referral Received').toList(),
                        onAdvance: controller.advanceStage,
                        onSchedule: (id) => _showScheduleModal(context, controller, id),
                      ),
                      const SizedBox(width: 16),
                      _KanbanColumn(
                        title: 'Initial Contact',
                        color: Colors.amber,
                        intakes: filtered.where((i) => i['stage'] == 'Initial Contact').toList(),
                        onAdvance: controller.advanceStage,
                        onSchedule: (id) => _showScheduleModal(context, controller, id),
                      ),
                      const SizedBox(width: 16),
                      _KanbanColumn(
                        title: 'Assessment Scheduled',
                        color: Colors.purple,
                        intakes: filtered.where((i) => i['stage'] == 'Assessment Scheduled').toList(),
                        onAdvance: controller.advanceStage,
                        onSchedule: (id) => _showScheduleModal(context, controller, id),
                      ),
                      const SizedBox(width: 16),
                      _KanbanColumn(
                        title: 'Approved',
                        color: Colors.green,
                        intakes: filtered.where((i) => i['stage'] == 'Approved').toList(),
                        onAdvance: null,
                        onSchedule: null,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),

          // Drawer backdrop & Slide Drawer
          if (state.isCreatingIntake) ...[
            GestureDetector(
              onTap: () => controller.toggleCreateDrawer(false),
              child: Container(
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: _NewIntakeFormDrawer(
                onSubmit: (name, source, urgency) {
                  controller.createIntake(name: name, source: source, urgency: urgency);
                },
                onCancel: () => controller.toggleCreateDrawer(false),
              ),
            ),
          ],

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

  void _showScheduleModal(BuildContext context, IntakePipelineController controller, String intakeId) {
    final theme = context.theme;
    String selectedNurse = 'Sarah Jenkins (PSW)';
    String dateVal = '2025-05-24';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: theme.colors.surface,
          title: Text(
            'Schedule Clinical Intake Assessment',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Assign a clinical caregiver to conduct cognitive, medical, and ADL checks.',
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedNurse,
                items: const [
                  DropdownMenuItem(value: 'Sarah Jenkins (PSW)', child: Text('Sarah Jenkins (PSW)')),
                  DropdownMenuItem(value: 'David Miller (RPN)', child: Text('David Miller (RPN)')),
                  DropdownMenuItem(value: 'Marcus Aurelius (COO)', child: Text('Marcus Aurelius (COO)')),
                ],
                onChanged: (val) {
                  if (val != null) selectedNurse = val;
                },
                decoration: InputDecoration(
                  labelText: 'Select Registered Nurse/RPN',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(key: const Key('intake_pipeline_textfield_input_2'), 
                decoration: InputDecoration(
                  labelText: 'Scheduled Date (YYYY-MM-DD)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                  ),
                ),
                controller: TextEditingController(text: dateVal),
                onChanged: (val) => dateVal = val,
              ),
            ],
          ),
          actions: [
            TextButton(key: const Key('intake_pipeline_textbutton_button_1'), 
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel', style: TextStyle(color: theme.colors.onSurfaceVariant)),
            ),
            ElevatedButton(key: const Key('intake_pipeline_elevatedbutton_button_1'), 
              onPressed: () {
                controller.scheduleAssessment(intakeId, selectedNurse, dateVal);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Confirm Schedule'),
            ),
          ],
        );
      },
    );
  }
}

class _KanbanColumn extends StatelessWidget {
  final String title;
  final Color color;
  final List<Map<String, dynamic>> intakes;
  final ValueChanged<String>? onAdvance;
  final ValueChanged<String>? onSchedule;

  const _KanbanColumn({
    required this.title,
    required this.color,
    required this.intakes,
    required this.onAdvance,
    required this.onSchedule,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: theme.colors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Column Header Banner
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: theme.typography.h4.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${intakes.length}',
                    style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 11),
                  ),
                )
              ],
            ),
            const SizedBox(height: 4),
            Container(height: 2, color: color),
            const SizedBox(height: 16),

            // Intake Cards List
            Expanded(
              child: ListView.builder(
                itemCount: intakes.length,
                itemBuilder: (context, index) {
                  final intake = intakes[index];
                  final isHigh = intake['urgency'] == 'high';
                  final Color labelColor = isHigh 
                      ? Colors.red 
                      : intake['urgency'] == 'medium' 
                          ? Colors.amber 
                          : Colors.blue;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: theme.colors.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              (intake['name'] as String),
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                              decoration: BoxDecoration(
                                color: labelColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                intake['urgency'].toString().toUpperCase(),
                                style: TextStyle(color: labelColor, fontWeight: FontWeight.bold, fontSize: 8),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Source: ${intake['source']}',
                          style: TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 11),
                        ),
                        if (intake['nurse'].toString().isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(LucideIcons.user, size: 12, color: Colors.purple),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  'Clinician: ${intake['nurse']}',
                                  style: const TextStyle(color: Colors.purple, fontSize: 11, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(LucideIcons.calendar, size: 12, color: Colors.purple),
                              const SizedBox(width: 4),
                              Text(
                                'Scheduled: ${intake['date']}',
                                style: TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 11),
                              ),
                            ],
                          ),
                        ] else ...[
                          const SizedBox(height: 4),
                          Text(
                            'Referred: ${intake['date']}',
                            style: TextStyle(color: theme.colors.onSurfaceVariant, fontSize: 11),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if (onSchedule != null && intake['stage'] != 'Assessment Scheduled') ...[
                              TextButton.icon(
                                icon: const Icon(LucideIcons.calendar, size: 14),
                                label: const Text('Schedule', style: TextStyle(fontSize: 11)),
                                onPressed: () => onSchedule!((intake['id'] as String)),
                              ),
                            ],
                            if (onAdvance != null) ...[
                              ElevatedButton(key: const Key('intake_pipeline_elevatedbutton_button_2'), 
                                onPressed: () => onAdvance!((intake['id'] as String)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colors.primary,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  minimumSize: Size.zero,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Text('Advance', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                    Icon(LucideIcons.chevronRight, size: 12),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _UrgencyTab extends StatelessWidget {
  final String label;
  final String value;
  final String activeFilter;
  final ValueChanged<String> onTap;

  const _UrgencyTab({
    required this.label,
    required this.value,
    required this.activeFilter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeFilter;

    return GestureDetector(
      onTap: () => onTap(value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? theme.colors.primary : theme.colors.background,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: isActive ? theme.colors.primary : theme.colors.border),
        ),
        child: Text(
          label,
          style: theme.typography.bodyMedium.copyWith(
            color: isActive ? Colors.white : theme.colors.onSurface,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _NewIntakeFormDrawer extends StatefulWidget {
  final Function(String name, String source, String urgency) onSubmit;
  final VoidCallback onCancel;

  const _NewIntakeFormDrawer({required this.onSubmit, required this.onCancel});

  @override
  State<_NewIntakeFormDrawer> createState() => _NewIntakeFormDrawerState();
}

class _NewIntakeFormDrawerState extends State<_NewIntakeFormDrawer> {
  final _nameController = TextEditingController();
  final _sourceController = TextEditingController();
  String _selectedUrgency = 'medium';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      width: 400,
      height: double.infinity,
      color: theme.colors.surface,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 48),
          Text(
            'New Client Intake Lead',
            style: theme.typography.h3.copyWith(color: theme.colors.onSurface, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Register incoming referral logs from health care partners or private inquiries.',
            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
          ),
          const SizedBox(height: 24),
          TextField(key: const Key('intake_pipeline_textfield_input_3'), 
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Client Full Name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: 16),
          TextField(key: const Key('intake_pipeline_textfield_input_4'), 
            controller: _sourceController,
            decoration: InputDecoration(
              labelText: 'Referral Lead Source',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusMd),
              ),
            ),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedUrgency,
            items: const [
              DropdownMenuItem(value: 'high', child: Text('High Urgency')),
              DropdownMenuItem(value: 'medium', child: Text('Medium Urgency')),
              DropdownMenuItem(value: 'low', child: Text('Low Urgency')),
            ],
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedUrgency = val;
                });
              }
            },
            decoration: InputDecoration(
              labelText: 'Onboarding Escalation Level',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusMd),
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(key: const Key('intake_pipeline_outlinedbutton_button_1'), 
                  onPressed: widget.onCancel,
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                    ),
                  ),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(key: const Key('intake_pipeline_elevatedbutton_button_3'), 
                  onPressed: () {
                    if (_nameController.text.isNotEmpty && _sourceController.text.isNotEmpty) {
                      widget.onSubmit(_nameController.text, _sourceController.text, _selectedUrgency);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                    ),
                  ),
                  child: const Text('Add Lead'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
