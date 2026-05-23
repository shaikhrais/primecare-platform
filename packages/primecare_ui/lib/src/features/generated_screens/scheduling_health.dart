// Governance - Category: service | Purpose: Core implementation file for the Scheduling Health platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class SchedulingHealthState {
  final List<Map<String, dynamic>> schedules;
  final String searchQuery;
  final String activeMetricFilter;
  final bool isResolvingConflict;
  final String? resolvingScheduleId;

  const SchedulingHealthState({
    required this.schedules,
    required this.searchQuery,
    required this.activeMetricFilter,
    required this.isResolvingConflict,
    this.resolvingScheduleId,
  });

  SchedulingHealthState copyWith({
    List<Map<String, dynamic>>? schedules,
    String? searchQuery,
    String? activeMetricFilter,
    bool? isResolvingConflict,
    String? resolvingScheduleId,
  }) {
    return SchedulingHealthState(
      schedules: schedules ?? this.schedules,
      searchQuery: searchQuery ?? this.searchQuery,
      activeMetricFilter: activeMetricFilter ?? this.activeMetricFilter,
      isResolvingConflict: isResolvingConflict ?? this.isResolvingConflict,
      resolvingScheduleId: resolvingScheduleId ?? this.resolvingScheduleId,
    );
  }
}

// --- Controller ---
class SchedulingHealthController extends StateNotifier<SchedulingHealthState> {
  final Ref _ref;

  SchedulingHealthController(this._ref)
      : super(
          const SchedulingHealthState(
            schedules: [
              {
                'id': 'sch-7001',
                'caregiver': 'Elena Rostova',
                'client': 'Aria Vance',
                'type': 'Double-Booking Conflict',
                'time': '08:00 AM - 12:00 PM',
                'status': 'Unresolved Critical',
                'notes': 'Double scheduled with Caleb Brooks at 09:30 AM.',
              },
              {
                'id': 'sch-7002',
                'caregiver': 'Marcus Brody',
                'client': 'Diana Prince',
                'type': 'Late Clock-In Anomaly',
                'time': '02:00 PM - 06:00 PM',
                'status': 'Needs Attention',
                'notes': 'Scheduled 22 mins ago. No GPS signal coordinates logged.',
              },
              {
                'id': 'sch-7003',
                'caregiver': 'Unassigned Shift Pool',
                'client': 'Bruce Wayne',
                'type': 'Unassigned Client Roster',
                'time': '09:00 AM - 05:00 PM',
                'status': 'Pending Staffing',
                'notes': 'Requires Specialized Nursing credential levels.',
              },
              {
                'id': 'sch-7004',
                'caregiver': 'Sara Connor',
                'client': 'John Connor',
                'type': 'Double-Booking Conflict',
                'time': '10:00 AM - 02:00 PM',
                'status': 'Resolved Optimal',
                'notes': 'Re-allocated backup support caregiver automatically.',
              },
            ],
            searchQuery: '',
            activeMetricFilter: 'all',
            isResolvingConflict: false,
          ),
        );

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateMetricFilter(String filter) {
    state = state.copyWith(activeMetricFilter: filter);
  }

  void resolveConflict(String id) {
    state = state.copyWith(
      isResolvingConflict: true,
      resolvingScheduleId: id,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/scheduling_health',
            eventType: 'scheduling_conflict_resolution_triggered',
            metadata: {
              'schedule_id': id,
              'timestamp': DateTime.now().toIso8601String(),
            },
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 1400), () {
      final updated = state.schedules.map((sch) {
        if (sch['id'] == id) {
          return {
            ...sch,
            'status': 'Resolved Optimal',
            'notes': 'Successfully split shift coordinates and resolved double booking.',
          };
        }
        return sch;
      }).toList();

      state = state.copyWith(
        schedules: updated,
        isResolvingConflict: false,
        resolvingScheduleId: null,
      );
    });
  }
}

// --- Provider ---
final schedulingHealthControllerProvider =
    StateNotifierProvider<SchedulingHealthController, SchedulingHealthState>((ref) {
  return SchedulingHealthController(ref);
});

// --- View ---
class SchedulingHealth extends GovernedConsumerWidget {
  const SchedulingHealth({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schedulingHealthControllerProvider);
    final controller = ref.read(schedulingHealthControllerProvider.notifier);
    final theme = context.theme;

    // Filter schedules
    final filteredSchedules = state.schedules.where((sch) {
      final matchesSearch = (sch['caregiver'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (sch['client'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (sch['type'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      final matchesFilter = state.activeMetricFilter == 'all' ||
          (sch['type'] as String).toLowerCase().contains(state.activeMetricFilter.toLowerCase());
      return matchesSearch && matchesFilter;
    }).toList();

    // Stats calculations
    int totalIssues = 0;
    int unresolvedCritical = 0;
    int unassignedCount = 0;
    for (final sch in state.schedules) {
      totalIssues++;
      if (sch['status'] == 'Unresolved Critical') {
        unresolvedCritical++;
      }
      if (sch['type'] == 'Unassigned Client Roster') {
        unassignedCount++;
      }
    }

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.calendarCheck, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'COO Scheduling Health Monitor',
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Scheduling Health Matrix',
                          style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Audit double-booking anomalies, analyze shift latency logs, and reconcile unassigned caregivers.',
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // KPIs Cards
                Row(
                  children: [
                    Expanded(
                      child: _MetricCard(
                        title: 'Total Alert Flags',
                        value: '$totalIssues',
                        icon: LucideIcons.bellRing,
                        color: theme.colors.primary,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Unassigned Shifts Pool',
                        value: '$unassignedCount shifts',
                        icon: LucideIcons.helpCircle,
                        color: Colors.amber,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _MetricCard(
                        title: 'Critical Double-Bookings',
                        value: '$unresolvedCritical active',
                        icon: LucideIcons.alertOctagon,
                        color: unresolvedCritical > 0 ? Colors.red : Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Controls
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
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search by caregiver, client, or anomaly type...',
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
                          _FilterChip(
                            label: 'All Alerts',
                            value: 'all',
                            activeValue: state.activeMetricFilter,
                            onTap: controller.updateMetricFilter,
                          ),
                          _FilterChip(
                            label: 'Double-Booking',
                            value: 'double-booking',
                            activeValue: state.activeMetricFilter,
                            onTap: controller.updateMetricFilter,
                          ),
                          _FilterChip(
                            label: 'Late Clock-In',
                            value: 'late clock-in',
                            activeValue: state.activeMetricFilter,
                            onTap: controller.updateMetricFilter,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Live Ledger Anomaly List
                Expanded(
                  child: filteredSchedules.isEmpty
                      ? Center(
                          child: Text(
                            'Optimal schedule alignment. No anomalies logged.',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredSchedules.length,
                          itemBuilder: (context, index) {
                            final sch = filteredSchedules[index];
                            final id = sch['id'] as String;
                            final type = sch['type'];
                            final status = sch['status'] as String;
                            final isCritical = status == 'Unresolved Critical';
                            final isResolved = status == 'Resolved Optimal';
                            final isLate = type == 'Late Clock-In Anomaly';

                            final statusColor = isResolved
                                ? Colors.green
                                : isCritical
                                    ? Colors.red
                                    : Colors.amber;

                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: theme.colors.surface,
                                borderRadius: BorderRadius.circular(theme.radiusMd),
                                border: Border.all(color: theme.colors.border),
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: statusColor.withValues(alpha: 0.1),
                                    child: Icon(
                                      isLate
                                          ? LucideIcons.clock
                                          : isResolved
                                              ? LucideIcons.checkSquare
                                              : LucideIcons.alertTriangle,
                                      color: statusColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              (sch['caregiver'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Icon(LucideIcons.arrowRight, size: 14, color: theme.colors.onSurfaceVariant),
                                            const SizedBox(width: 8),
                                            Text(
                                              (sch['client'] as String),
                                              style: theme.typography.h4.copyWith(
                                                color: theme.colors.onSurface,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          'Type: $type • Window: ${sch['time']}',
                                          style: theme.typography.bodyMedium.copyWith(
                                            color: theme.colors.onSurfaceVariant,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Notes: ${sch['notes']}',
                                          style: theme.typography.bodyMedium.copyWith(
                                            color: theme.colors.onSurfaceVariant,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  if (isCritical)
                                    ElevatedButton(
                                      onPressed: state.isResolvingConflict
                                          ? null
                                          : () => controller.resolveConflict(id),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: theme.colors.primary,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(theme.radiusMd),
                                        ),
                                      ),
                                      child: const Text('Resolve Conflict'),
                                    )
                                  else
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: statusColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(theme.radiusMd),
                                        border: Border.all(color: statusColor.withValues(alpha: 0.2)),
                                      ),
                                      child: Text(
                                        status,
                                        style: theme.typography.bodySmall.copyWith(
                                          color: statusColor,
                                          fontWeight: FontWeight.bold,
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
          if (state.isResolvingConflict)
            Container(
              color: Colors.black.withValues(alpha: 0.25),
              child: Center(
                child: Card(
                  color: theme.colors.surface,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(theme.radiusLg),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const CircularProgressIndicator(),
                        const SizedBox(height: 16),
                        Text(
                          'Re-allocating Dispatch Coordination Matrices...',
                          style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Routing backup staff and pushing updates to field employee devices...',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.border),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withValues(alpha: 0.1),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: theme.typography.h2.copyWith(
                  color: theme.colors.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final String value;
  final String activeValue;
  final ValueChanged<String> onTap;

  const _FilterChip({
    required this.label,
    required this.value,
    required this.activeValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isActive = value == activeValue;

    return ChoiceChip(
      label: Text(label),
      selected: isActive,
      selectedColor: theme.colors.primary.withValues(alpha: 0.2),
      backgroundColor: theme.colors.surface,
      labelStyle: TextStyle(
        color: isActive ? theme.colors.primary : theme.colors.onSurface,
        fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        side: BorderSide(
          color: isActive ? theme.colors.primary : theme.colors.border,
        ),
      ),
      onSelected: (val) {
        if (val) onTap(value);
      },
    );
  }
}
