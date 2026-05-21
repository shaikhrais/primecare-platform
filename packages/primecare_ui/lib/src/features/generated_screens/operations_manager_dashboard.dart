import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class OperationsManagerDashboardState {
  final List<Map<String, dynamic>> activeShifts;
  final int activeCaregivers;
  final int openRequirements;
  final double dispatchFulfillRate;
  final String priorityFilter;
  final bool isMutatingState;

  const OperationsManagerDashboardState({
    required this.activeShifts,
    required this.activeCaregivers,
    required this.openRequirements,
    required this.dispatchFulfillRate,
    required this.priorityFilter,
    required this.isMutatingState,
  });

  OperationsManagerDashboardState copyWith({
    List<Map<String, dynamic>>? activeShifts,
    int? activeCaregivers,
    int? openRequirements,
    double? dispatchFulfillRate,
    String? priorityFilter,
    bool? isMutatingState,
  }) {
    return OperationsManagerDashboardState(
      activeShifts: activeShifts ?? this.activeShifts,
      activeCaregivers: activeCaregivers ?? this.activeCaregivers,
      openRequirements: openRequirements ?? this.openRequirements,
      dispatchFulfillRate: dispatchFulfillRate ?? this.dispatchFulfillRate,
      priorityFilter: priorityFilter ?? this.priorityFilter,
      isMutatingState: isMutatingState ?? this.isMutatingState,
    );
  }
}

// --- Controller ---
class OperationsManagerDashboardController extends StateNotifier<OperationsManagerDashboardState> {
  final Ref _ref;

  OperationsManagerDashboardController(this._ref)
      : super(
          const OperationsManagerDashboardState(
            activeShifts: [
              {
                'id': 'sh-901',
                'caregiver': 'Robert Vance',
                'client': 'Arthur Pendelton',
                'time': '08:00 - 16:00',
                'status': 'In Progress',
                'priority': 'High',
              },
              {
                'id': 'sh-902',
                'caregiver': 'Maria Gonzalez',
                'client': 'James Anderson',
                'time': '09:00 - 13:00',
                'status': 'In Progress',
                'priority': 'Medium',
              },
              {
                'id': 'sh-903',
                'caregiver': 'Sylvia Plath',
                'client': 'Clara Oswald',
                'time': '10:00 - 18:00',
                'status': 'Delayed',
                'priority': 'High',
              },
              {
                'id': 'sh-904',
                'caregiver': 'Jonathan Harker',
                'client': 'Mina Murray',
                'time': '11:00 - 15:00',
                'status': 'Scheduled',
                'priority': 'Low',
              },
            ],
            activeCaregivers: 84,
            openRequirements: 12,
            dispatchFulfillRate: 0.925,
            priorityFilter: 'All',
            isMutatingState: false,
          ),
        );

  void setFilter(String filter) {
    state = state.copyWith(priorityFilter: filter);
  }

  void triggerStaffingSync() {
    state = state.copyWith(isMutatingState: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/operations_manager_dashboard',
            eventType: 'staffing_sync_triggered',
            metadata: {
              'sync_time': DateTime.now().toIso8601String(),
              'current_fulfill_rate': state.dispatchFulfillRate,
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 400), () {
      final updatedShifts = state.activeShifts.map((s) {
        if (s['status'] == 'Delayed') {
          return {
            ...s,
            'status': 'In Progress',
          };
        }
        return s;
      }).toList();

      state = state.copyWith(
        activeShifts: updatedShifts,
        activeCaregivers: 88,
        openRequirements: 8,
        dispatchFulfillRate: 0.954,
        isMutatingState: false,
      );
    });
  }
}

// --- Provider ---
final operationsManagerDashboardControllerProvider =
    StateNotifierProvider<OperationsManagerDashboardController, OperationsManagerDashboardState>((ref) {
  return OperationsManagerDashboardController(ref);
});

// --- View ---
class OperationsManagerDashboard extends GovernedConsumerWidget {
  const OperationsManagerDashboard({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(operationsManagerDashboardControllerProvider);
    final controller = ref.read(operationsManagerDashboardControllerProvider.notifier);
    final theme = context.theme;

    final filteredShifts = state.activeShifts.where((s) {
      if (state.priorityFilter == 'All') return true;
      return s['priority'] == state.priorityFilter;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.sliders, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Operations Manager Control Dashboard',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: ElevatedButton.icon(
              onPressed: () => controller.triggerStaffingSync(),
              icon: const Icon(LucideIcons.refreshCw, size: 16),
              label: const Text('Sync Operations'),
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colors.primary,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Daily Dispatch & Coordination Control Room',
                            style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Oversee live caregiver clock-ins, resolve delay status warnings, and monitor schedulers dispatch ratios.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<String>(
                      value: state.priorityFilter,
                      onChanged: (val) {
                        if (val != null) controller.setFilter(val);
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
                const SizedBox(height: 24),

                // Operational KPIs
                Row(
                  children: [
                    Expanded(
                      child: _OpsKpiCard(
                        title: 'Active Caregivers In Field',
                        value: '${state.activeCaregivers}',
                        subtitle: 'Live shifts verification',
                        icon: LucideIcons.userCheck,
                        iconColor: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _OpsKpiCard(
                        title: 'Open Schedule Gaps',
                        value: '${state.openRequirements}',
                        subtitle: 'Urgent staffing slots',
                        icon: LucideIcons.calendarDays,
                        iconColor: state.openRequirements > 10 ? Colors.red : Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _OpsKpiCard(
                        title: 'Dispatch Fulfillment',
                        value: '${(state.dispatchFulfillRate * 100).toStringAsFixed(1)}%',
                        subtitle: 'Shift completion metrics',
                        icon: LucideIcons.activity,
                        iconColor: Colors.purple,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Shifts Table Ledger
                Text(
                  'Live Field Shifts Ledger',
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: filteredShifts.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Center(
                            child: Text(
                              'No operational shifts match the selected priority filter.',
                              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredShifts.length,
                          separatorBuilder: (context, index) => Divider(height: 1, color: theme.colors.border),
                          itemBuilder: (context, index) {
                            final item = filteredShifts[index];
                            final status = item['status'] as String;
                            final statusColor = status == 'In Progress'
                                ? Colors.green
                                : status == 'Delayed'
                                    ? Colors.red
                                    : Colors.blue;

                            final priority = item['priority'];
                            final priorityColor = priority == 'High'
                                ? Colors.red
                                : priority == 'Medium'
                                    ? Colors.amber
                                    : Colors.grey;

                            return ListTile(
                              leading: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  status == 'Delayed' ? LucideIcons.alertOctagon : LucideIcons.clock,
                                  color: statusColor,
                                  size: 16,
                                ),
                              ),
                              title: Text(
                                '${item['caregiver']} ➔ ${item['client']}',
                                style: theme.typography.bodyMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: theme.colors.onSurface,
                                ),
                              ),
                              subtitle: Text('Shift Schedule: ${item['time']}'),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: priorityColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(color: priorityColor.withValues(alpha: 0.3)),
                                    ),
                                    child: Text(
                                      '$priority Priority',
                                      style: TextStyle(
                                        color: priorityColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: statusColor.withValues(alpha: 0.3)),
                                    ),
                                    child: Text(
                                      status,
                                      style: TextStyle(
                                        color: statusColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
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
}

class _OpsKpiCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;

  const _OpsKpiCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Card(
      color: theme.colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(color: theme.colors.border),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: theme.typography.h2.copyWith(
                      color: theme.colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
