import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class SchedulerCalendarState {
  final List<Map<String, dynamic>> shifts;
  final DateTime selectedDate;
  final List<String> conflictIds;
  final bool isCreatingShift;
  final String activeViewType; // 'day', 'week', 'month'

  const SchedulerCalendarState({
    required this.shifts,
    required this.selectedDate,
    required this.conflictIds,
    required this.isCreatingShift,
    required this.activeViewType,
  });

  SchedulerCalendarState copyWith({
    List<Map<String, dynamic>>? shifts,
    DateTime? selectedDate,
    List<String>? conflictIds,
    bool? isCreatingShift,
    String? activeViewType,
  }) {
    return SchedulerCalendarState(
      shifts: shifts ?? this.shifts,
      selectedDate: selectedDate ?? this.selectedDate,
      conflictIds: conflictIds ?? this.conflictIds,
      isCreatingShift: isCreatingShift ?? this.isCreatingShift,
      activeViewType: activeViewType ?? this.activeViewType,
    );
  }
}

// --- Controller ---
class SchedulerCalendarController extends StateNotifier<SchedulerCalendarState> {
  final Ref _ref;

  SchedulerCalendarController(this._ref)
      : super(
          SchedulerCalendarState(
            shifts: [
              {
                'id': 's-201',
                'caregiver': 'Sarah Jenkins, PSW',
                'client': 'Margaret Thompson',
                'timeStart': '08:00 AM',
                'timeEnd': '12:00 PM',
                'category': 'Daily Care',
                'notes': 'Assist with morning ADLs and physical exercise.',
                'status': 'confirmed',
                'isDoubleBooked': false,
              },
              {
                'id': 's-202',
                'caregiver': 'David Miller, RPN',
                'client': 'James Wilson',
                'timeStart': '09:00 AM',
                'timeEnd': '11:00 AM',
                'category': 'Clinical Medication',
                'notes': 'Wound care dressing change and vital signs logging.',
                'status': 'confirmed',
                'isDoubleBooked': false,
              },
              {
                'id': 's-203',
                'caregiver': 'Elena Rostova, RN',
                'client': 'Sophie Leblanc',
                'timeStart': '10:00 AM',
                'timeEnd': '01:00 PM',
                'category': 'Specialized Assessment',
                'notes': 'Quarterly cognitive and mobility mapping evaluation.',
                'status': 'pending',
                'isDoubleBooked': true, // Conflict simulator
              },
            ],
            selectedDate: DateTime(2026, 5, 20),
            conflictIds: const ['s-203'],
            isCreatingShift: false,
            activeViewType: 'day',
          ),
        );

  void setViewType(String viewType) {
    state = state.copyWith(activeViewType: viewType);
  }

  void selectDate(DateTime date) {
    state = state.copyWith(selectedDate: date);
  }

  void addShift(String caregiver, String client, String start, String end, String category, String notes) {
    state = state.copyWith(isCreatingShift: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/scheduler_calendar',
            eventType: 'scheduler_shift_created',
            metadata: {
              'caregiver': caregiver,
              'client': client,
              'timeStart': start,
              'timeEnd': end,
              'category': category,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 600), () {
      final newShift = {
        'id': 's-${DateTime.now().millisecondsSinceEpoch}',
        'caregiver': caregiver,
        'client': client,
        'timeStart': start,
        'timeEnd': end,
        'category': category,
        'notes': notes,
        'status': 'confirmed',
        'isDoubleBooked': false,
      };

      state = state.copyWith(
        isCreatingShift: false,
        shifts: [...state.shifts, newShift],
      );
    });
  }

  void resolveConflict(String shiftId) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/scheduler_calendar',
            eventType: 'scheduler_conflict_resolved',
            metadata: {'shiftId': shiftId},
          );
    } catch (_) {}

    final updated = state.shifts.map((s) {
      if (s['id'] == shiftId) {
        return {...s, 'isDoubleBooked': false, 'status': 'confirmed'};
      }
      return s;
    }).toList();

    state = state.copyWith(
      shifts: updated,
      conflictIds: state.conflictIds.where((id) => id != shiftId).toList(),
    );
  }

  void deleteShift(String shiftId) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/scheduler_calendar',
            eventType: 'scheduler_shift_removed',
            metadata: {'shiftId': shiftId},
          );
    } catch (_) {}

    state = state.copyWith(
      shifts: state.shifts.where((s) => s['id'] != shiftId).toList(),
      conflictIds: state.conflictIds.where((id) => id != shiftId).toList(),
    );
  }
}

// --- Provider ---
final schedulerCalendarControllerProvider =
    StateNotifierProvider<SchedulerCalendarController, SchedulerCalendarState>((ref) {
  return SchedulerCalendarController(ref);
});

// --- View ---
class SchedulerCalendarScreen extends GovernedConsumerWidget {
  const SchedulerCalendarScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schedulerCalendarControllerProvider);
    final controller = ref.read(schedulerCalendarControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.calendar, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Shift Planner Calendar',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sidebar: Left Calendar Controller Panel & Conflicts Alert Hub
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Calendar Matrix',
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Scheduling Roster coordination & shift matching.',
                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),

                  // Calendar Controls
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colors.surface,
                      borderRadius: BorderRadius.circular(theme.radiusMd),
                      border: Border.all(color: theme.colors.border),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'May 2026',
                              style: theme.typography.bodyLarge.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colors.onSurface,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(LucideIcons.chevronLeft, size: 18),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(LucideIcons.chevronRight, size: 18),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Quick 7-Day Matrix Week Selector
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(7, (index) {
                            final dateDay = 18 + index;
                            final isSelected = dateDay == state.selectedDate.day;
                            final dateVal = DateTime(2026, 5, dateDay);
                            return GestureDetector(
                              onTap: () => controller.selectDate(dateVal),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected ? theme.colors.primary : Colors.transparent,
                                  borderRadius: BorderRadius.circular(theme.radiusSm),
                                  border: Border.all(
                                    color: isSelected ? theme.colors.primary : theme.colors.border,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      ['M', 'T', 'W', 'T', 'F', 'S', 'S'][index],
                                      style: theme.typography.labelMedium.copyWith(
                                        color: isSelected ? Colors.white : theme.colors.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      '$dateDay',
                                      style: theme.typography.bodyMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isSelected ? Colors.white : theme.colors.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Conflict warning panel
                  if (state.conflictIds.isNotEmpty) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        border: Border.all(color: Colors.red.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Icon(LucideIcons.alertTriangle, color: Colors.red),
                              const SizedBox(width: 8),
                              Text(
                                'Double-Booking Warning',
                                style: theme.typography.bodyLarge.copyWith(
                                  color: Colors.red.shade900,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Caregiver is already assigned to another shift during this window.',
                            style: theme.typography.bodyMedium.copyWith(color: Colors.red.shade800),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () => controller.resolveConflict(state.conflictIds.first),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                            child: const Text('Resolve / Auto-Shift'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Add shift Trigger
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(LucideIcons.plus, size: 18),
                      label: const Text('Schedule New Shift'),
                      onPressed: () => _showAddShiftSheet(context, controller),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colors.primary,
                        foregroundColor: theme.colors.onPrimary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(theme.radiusMd),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Central Board Grid Area
          Expanded(
            flex: 6,
            child: Container(
              color: theme.colors.surface.withValues(alpha: 0.3),
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // View Selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Shift Matrix: Day View',
                        style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                      ),
                      Row(
                        children: [
                          _buildViewButton(context, 'Day', 'day', state.activeViewType, controller.setViewType),
                          const SizedBox(width: 8),
                          _buildViewButton(context, 'Week', 'week', state.activeViewType, controller.setViewType),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Interactive Shift Cards Matrix
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.shifts.length,
                      itemBuilder: (context, index) {
                        final shift = state.shifts[index];
                        final isConflict = shift['isDoubleBooked'] == true;

                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: theme.colors.surface,
                            borderRadius: BorderRadius.circular(theme.radiusMd),
                            border: Border.all(
                              color: isConflict ? Colors.red : theme.colors.border,
                              width: isConflict ? 2 : 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.02),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              )
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: BoxDecoration(
                                          color: isConflict ? Colors.red : Colors.green,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '${shift['timeStart']} - ${shift['timeEnd']}',
                                        style: theme.typography.labelBold.copyWith(
                                          color: isConflict ? Colors.red : theme.colors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(LucideIcons.trash2, size: 16, color: Colors.red),
                                        onPressed: () => controller.deleteShift((shift['id'] as String)),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Caregiver: ${shift['caregiver']}',
                                style: theme.typography.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Patient: ${shift['client']}',
                                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: theme.colors.onSurface.withValues(alpha: 0.04),
                                  borderRadius: BorderRadius.circular(theme.radiusSm),
                                ),
                                child: Text(
                                  (shift['category'] as String),
                                  style: theme.typography.labelMedium.copyWith(color: theme.colors.primary),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                (shift['notes'] as String),
                                style: theme.typography.bodyMedium.copyWith(
                                  color: theme.colors.onSurfaceVariant,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildViewButton(
    BuildContext context,
    String label,
    String viewVal,
    String activeView,
    ValueChanged<String> onSelected,
  ) {
    final theme = context.theme;
    final isSelected = viewVal == activeView;
    return OutlinedButton(
      onPressed: () => onSelected(viewVal),
      style: OutlinedButton.styleFrom(
        backgroundColor: isSelected ? theme.colors.primary : Colors.transparent,
        foregroundColor: isSelected ? Colors.white : theme.colors.onSurface,
        side: BorderSide(color: isSelected ? theme.colors.primary : theme.colors.border),
      ),
      child: Text(label),
    );
  }

  void _showAddShiftSheet(BuildContext context, SchedulerCalendarController controller) {
    final theme = context.theme;
    final caregiverController = TextEditingController(text: 'Sarah Jenkins, PSW');
    final clientController = TextEditingController(text: 'Margaret Thompson');
    final startController = TextEditingController(text: '02:00 PM');
    final endController = TextEditingController(text: '05:00 PM');
    final categoryController = TextEditingController(text: 'Daily Care Check-in');
    final notesController = TextEditingController(text: 'Verify nutritional plans and support routine mobility walk.');

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 24,
            right: 24,
            top: 24,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Schedule Caregiver Shift',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: caregiverController,
                  decoration: const InputDecoration(labelText: 'Caregiver Name (and credentials)'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: clientController,
                  decoration: const InputDecoration(labelText: 'Patient / Client Name'),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: startController,
                        decoration: const InputDecoration(labelText: 'Start Time'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextFormField(
                        controller: endController,
                        decoration: const InputDecoration(labelText: 'End Time'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Roster Category'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: notesController,
                  maxLines: 2,
                  decoration: const InputDecoration(labelText: 'Operational Notes'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      controller.addShift(
                        caregiverController.text,
                        clientController.text,
                        startController.text,
                        endController.text,
                        categoryController.text,
                        notesController.text,
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colors.primary,
                      foregroundColor: theme.colors.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Save Shift Plan'),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
