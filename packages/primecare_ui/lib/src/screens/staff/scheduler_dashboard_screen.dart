// Governance - Category: view | Purpose: --- MVC Shift Entry Model ---
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC Shift Entry Model ---
class ShiftEntry {
  final String id;
  final String staffName;
  final String role;
  final String patientName;
  final String timeWindow;
  final String status; // 'Confirmed', 'Pending', 'Resolving...', 'Canceled'
  final bool hasConflict;

  const ShiftEntry({
    required this.id,
    required this.staffName,
    required this.role,
    required this.patientName,
    required this.timeWindow,
    required this.status,
    required this.hasConflict,
  });

  ShiftEntry copyWith({
    String? status,
    bool? hasConflict,
    String? staffName,
  }) {
    return ShiftEntry(
      id: id,
      staffName: staffName ?? this.staffName,
      role: role,
      patientName: patientName,
      timeWindow: timeWindow,
      status: status ?? this.status,
      hasConflict: hasConflict ?? this.hasConflict,
    );
  }
}

// --- MVC State Model ---
class SchedulerDashboardState {
  final bool isLoading;
  final String? error;
  final String activeRoleFilter; // 'All', 'RN', 'RPN', 'PSW'
  final List<ShiftEntry> shifts;
  final double capacityBufferPercent;
  final List<String> logs;

  const SchedulerDashboardState({
    required this.isLoading,
    this.error,
    required this.activeRoleFilter,
    required this.shifts,
    required this.capacityBufferPercent,
    required this.logs,
  });

  SchedulerDashboardState copyWith({
    bool? isLoading,
    String? error,
    String? activeRoleFilter,
    List<ShiftEntry>? shifts,
    double? capacityBufferPercent,
    List<String>? logs,
  }) {
    return SchedulerDashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      activeRoleFilter: activeRoleFilter ?? this.activeRoleFilter,
      shifts: shifts ?? this.shifts,
      capacityBufferPercent: capacityBufferPercent ?? this.capacityBufferPercent,
      logs: logs ?? this.logs,
    );
  }
}

// --- Controller (Notifier) ---
class SchedulerDashboardController extends StateNotifier<SchedulerDashboardState> {
  SchedulerDashboardController()
      : super(
          const SchedulerDashboardState(
            isLoading: false,
            activeRoleFilter: 'All',
            capacityBufferPercent: 15.0,
            shifts: [
              ShiftEntry(
                id: 'SH-801',
                staffName: 'Clara Oswald, RN',
                role: 'RN',
                patientName: 'Donald Noble',
                timeWindow: 'May 18, 08:00 - 16:00',
                status: 'Confirmed',
                hasConflict: false,
              ),
              ShiftEntry(
                id: 'SH-802',
                staffName: 'Sarah Smith, PSW',
                role: 'PSW',
                patientName: 'Wilfred Mott',
                timeWindow: 'May 18, 10:00 - 18:00',
                status: 'Pending',
                hasConflict: true, // Overtime warning conflict
              ),
              ShiftEntry(
                id: 'SH-803',
                staffName: 'Martha Jones, RN',
                role: 'RN',
                patientName: 'Donna Tyler',
                timeWindow: 'May 18, 14:00 - 22:00',
                status: 'Confirmed',
                hasConflict: false,
              ),
              ShiftEntry(
                id: 'SH-804',
                staffName: 'Rory Williams, RPN',
                role: 'RPN',
                patientName: 'Amy Pond',
                timeWindow: 'May 18, 07:00 - 15:00',
                status: 'Confirmed',
                hasConflict: false,
              ),
            ],
            logs: [
              '[SCHEDULER-INIT] Caregiver rosters parsed with 4 active shifts.',
              '[ROUTING-ENGINE] Optimized travel parameters applied for home care slots.',
              '[CAPACITY] Buffer threshold calibrated to 15.0% for overflow triage.',
            ],
          ),
        );

  void changeFilter(String role) {
    state = state.copyWith(activeRoleFilter: role);
  }

  void updateBuffer(double val) {
    state = state.copyWith(capacityBufferPercent: val);
  }

  Future<void> resolveConflict(String id) async {
    state = state.copyWith(
      shifts: state.shifts.map((s) => s.id == id ? s.copyWith(status: 'Resolving...') : s).toList(),
      logs: [
        ...state.logs,
        '[RESOLVER] Activating smart dispatch backup finder for shift $id.',
      ],
    );

    await Future<void>.delayed(const Duration(milliseconds: 1000));

    state = state.copyWith(
      shifts: state.shifts.map((s) {
        if (s.id == id) {
          return s.copyWith(
            status: 'Confirmed',
            hasConflict: false,
            staffName: 'Rose Tyler, PSW (Backup Auto-Assigned)',
          );
        }
        return s;
      }).toList(),
      logs: [
        ...state.logs,
        '[RESOLVER-SUCCESS] Reassigned $id to Rose Tyler. Conflict resolved.',
      ],
    );
  }

  Future<void> autoOptimizeSchedules() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 1500));

    final optimized = state.shifts.map((s) {
      if (s.hasConflict) {
        return s.copyWith(
          hasConflict: false,
          status: 'Confirmed',
          staffName: '${s.staffName} (Re-routed to Backup)',
        );
      }
      return s;
    }).toList();

    state = state.copyWith(
      isLoading: false,
      shifts: optimized,
      logs: [
        ...state.logs,
        '[OPTIMIZATION] Grid optimization sweep completed.',
        '[OPTIMIZATION] Zero overlaps remaining. Rested status verified.',
      ],
    );
  }

  void bookNewShift(String staff, String role, String patient, String time) {
    final newId = 'SH-${state.shifts.length + 801}';
    final entry = ShiftEntry(
      id: newId,
      staffName: staff,
      role: role,
      patientName: patient,
      timeWindow: time,
      status: 'Confirmed',
      hasConflict: false,
    );
    state = state.copyWith(
      shifts: [...state.shifts, entry],
      logs: [
        ...state.logs,
        '[BOOKING] Successfully registered shift $newId for $staff ($role).',
      ],
    );
  }

  void addLog(String log) {
    state = state.copyWith(logs: [...state.logs, log]);
  }

  void clearLogs() {
    state = state.copyWith(logs: []);
  }
}

// --- Provider ---
final schedulerDashboardProvider =
    StateNotifierProvider<SchedulerDashboardController, SchedulerDashboardState>((ref) {
  return SchedulerDashboardController();
});

// --- View ---
class SchedulerDashboardScreen extends GovernedConsumerWidget {
  const SchedulerDashboardScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(schedulerDashboardProvider);
    final controller = ref.read(schedulerDashboardProvider.notifier);
    final theme = context.theme;

    // Derived values
    final activeConflictsCount = state.shifts.where((s) => s.hasConflict).length;
    final totalShiftsCount = state.shifts.length;

    // Filter shifts based on active role filter
    final filteredShifts = state.shifts.where((s) {
      if (state.activeRoleFilter == 'All') return true; // .tr() LocaleKeys.
      return s.role == state.activeRoleFilter;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.calendar, color: theme.colors.primary, size: 24),
            const SizedBox(width: 8),
            Text(
              'Scheduler Control Center', // .tr() LocaleKeys.
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () {
              controller.addLog('[TELEMETRY] Refreshed active calendar grid metrics.'); // .tr() LocaleKeys.
            },
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: ResponsiveSplitDashboard(
            metrics: [
              GovMetricCard(
                title: 'Active Scheduled Shifts', // .tr() LocaleKeys.
                value: '$totalShiftsCount Placements', // .tr() LocaleKeys.
                trendLabel: 'Optimal placement load', // .tr() LocaleKeys.
                progress: 0.90,
                icon: LucideIcons.users,
                brandColor: theme.colors.primary,
              ),
              GovMetricCard(
                title: 'Scheduling Conflicts', // .tr() LocaleKeys.
                value: activeConflictsCount == 0 ? 'Zero Overlaps' : '$activeConflictsCount Warning Overlaps', // .tr() LocaleKeys.
                trendLabel: activeConflictsCount == 0 ? 'Optimal availability status' : 'Double bookings detected', // .tr() LocaleKeys.
                progress: activeConflictsCount == 0 ? 1.0 : 0.75,
                icon: LucideIcons.shieldAlert,
                brandColor: activeConflictsCount == 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
              ),
              GovMetricCard(
                title: 'Capacity Buffer', // .tr() LocaleKeys.
                value: '${state.capacityBufferPercent.toInt()}% Active Pool', // .tr() LocaleKeys.
                trendLabel: 'Franchise capacity threshold', // .tr() LocaleKeys.
                progress: state.capacityBufferPercent / 100.0,
                icon: LucideIcons.layers,
                brandColor: Colors.purple,
              ),
            ],
            mainContent: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Scheduler Hero Title Card ---
                GovDashboardHero(
                  title: 'Clinical Operations Scheduler', // .tr() LocaleKeys.
                  roleName: 'Scheduler Command HUD', // .tr() LocaleKeys.
                  description: 'Assign home care clinic slots, balance caregiver availability quotas, adjust backup pool capacities, and auto-optimize scheduling conflicts.', // .tr() LocaleKeys.
                  onRefresh: () => controller.addLog('[HUD-SYNC] Synced patient availability metrics.'), // .tr() LocaleKeys.
                ),
                const SizedBox(height: 24),

                // --- Interactive Roster Filtering Panel ---
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: theme.colors.surface,
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    border: Border.all(color: theme.colors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Active Caregiver Placement Slots', // .tr() LocaleKeys.
                            style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                          ),
                          // Auto-Optimizer Action Button
                          SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: theme.colors.primary,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(horizontal: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                              onPressed: state.isLoading ? null : () => controller.autoOptimizeSchedules(),
                              child: state.isLoading
                                  ? const SizedBox(
                                      height: 14,
                                      width: 14,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation(Colors.white),
                                      ),
                                    )
                                  : Row(
                                      children: [
                                        const Icon(LucideIcons.activity, color: Colors.white, size: 14),
                                        const SizedBox(width: 6),
                                        Text(
                                          'Auto-Optimize Grid', // .tr() LocaleKeys.
                                          style: theme.typography.button.copyWith(color: Colors.white, fontSize: 11),
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Filters tab bar
                      Row(
                        children: ['All', 'RN', 'RPN', 'PSW'].map((role) {
                          final isSelected = state.activeRoleFilter == role;
                          final filterColor = isSelected ? theme.colors.primary : theme.colors.surface;

                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: InkWell(
                              onTap: () => controller.changeFilter(role),
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                decoration: BoxDecoration(
                                  color: filterColor,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected ? theme.colors.primary : theme.colors.border,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  role, // .tr() LocaleKeys.
                                  style: theme.typography.button.copyWith(
                                    color: isSelected ? Colors.white : theme.colors.onSurfaceVariant,
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      // Render Shift placements cards
                      if (filteredShifts.isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Center(
                            child: Text(
                              'No active shifts registered for ${state.activeRoleFilter} role filter.', // .tr() LocaleKeys.
                              style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurfaceVariant),
                            ),
                          ),
                        )
                      else
                        ...filteredShifts.map((shift) {
                          final isConflict = shift.hasConflict;
                          final isResolving = shift.status == 'Resolving...'; // .tr() LocaleKeys.

                          Color cardBorder = theme.colors.border;
                          Color accentColor = theme.colors.primary;
                          if (isConflict) {
                            cardBorder = const Color(0xFFEF4444);
                            accentColor = const Color(0xFFEF4444);
                          } else if (shift.status == 'Pending') { // .tr() LocaleKeys.
                            cardBorder = const Color(0xFFF59E0B);
                            accentColor = const Color(0xFFF59E0B);
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: theme.colors.background,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: cardBorder),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: accentColor.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              shift.role,
                                              style: theme.typography.bodySmall.copyWith(
                                                color: accentColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            shift.id,
                                            style: theme.typography.bodySmall.copyWith(
                                              color: theme.colors.onSurfaceVariant,
                                              fontFamily: 'monospace',
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        shift.staffName,
                                        style: theme.typography.bodyLarge.copyWith(
                                          color: theme.colors.onSurface,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Patient: ${shift.patientName}', // .tr() LocaleKeys.
                                        style: theme.typography.bodyMedium.copyWith(
                                          color: theme.colors.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Timeline: ${shift.timeWindow}', // .tr() LocaleKeys.
                                        style: theme.typography.bodySmall.copyWith(
                                          color: theme.colors.onSurfaceVariant,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 12),
                                // Resolve Shift overlap action button
                                SizedBox(
                                  height: 36,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isConflict
                                          ? const Color(0xFFEF4444)
                                          : isResolving
                                              ? theme.colors.border
                                              : theme.colors.surface,
                                      foregroundColor: isConflict ? Colors.white : theme.colors.onSurface,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        side: isConflict ? BorderSide.none : BorderSide(color: theme.colors.border),
                                      ),
                                    ),
                                    onPressed: (isResolving || !isConflict)
                                        ? null
                                        : () => controller.resolveConflict(shift.id),
                                    child: isResolving
                                        ? const SizedBox(
                                            height: 14,
                                            width: 14,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                              valueColor: AlwaysStoppedAnimation(Colors.grey),
                                            ),
                                          )
                                        : Text(
                                            isConflict ? 'Resolve Overlap' : 'Scheduled', // .tr() LocaleKeys.
                                            style: theme.typography.button.copyWith(
                                              color: isConflict ? Colors.white : theme.colors.onSurfaceVariant,
                                              fontSize: 11,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                    ],
                  ),
                ),
              ],
            ),
            defaultSidebarWidgets: [
              // --- Shift Bookings Panel ---
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: theme.colors.surface,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: theme.colors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'On-Demand Shift Creation', // .tr() LocaleKeys.
                      style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Manually schedule backup pool members for urgent client inquiries.', // .tr() LocaleKeys.
                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                    ),
                    const SizedBox(height: 20),
                    // Dynamic sliders for overflow buffers
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Franchise Backup Capacity Buffer:', // .tr() LocaleKeys.
                          style: theme.typography.bodyLarge.copyWith(color: theme.colors.onSurface),
                        ),
                        Text(
                          '${state.capacityBufferPercent.toInt()}% Active Pool', // .tr() LocaleKeys.
                          style: theme.typography.h4.copyWith(
                            color: theme.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Slider(
                      activeColor: theme.colors.primary,
                      inactiveColor: theme.colors.border,
                      min: 5,
                      max: 50,
                      divisions: 9,
                      value: state.capacityBufferPercent,
                      onChanged: (val) => controller.updateBuffer(val),
                      onChangeEnd: (val) {
                        controller.addLog('[POLICY] Capacity margin threshold calibrated to ${val.toInt()}% buffer.'); // .tr() LocaleKeys.
                      },
                    ),
                    const Divider(height: 24),
                    // Simulated shift booker trigger
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colors.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          controller.bookNewShift(
                            'Danny Pink, RPN', // .tr() LocaleKeys.
                            'RPN',
                            'Sylvester McCoy', // .tr() LocaleKeys.
                            'May 18, 12:00 - 20:00', // .tr() LocaleKeys.
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.users, color: Colors.white, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              'Dispatch Backup Caregiver (On-Demand)', // .tr() LocaleKeys.
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // --- Monospace Scheduling Audit Console ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A), // Dark Slate
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: const Color(0xFF1E293B)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(LucideIcons.terminal, color: Color(0xFF38BDF8), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Chronological Scheduling Audit Trails', // .tr() LocaleKeys.
                              style: theme.typography.h4.copyWith(color: const Color(0xFFF8FAFC)),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(LucideIcons.trash2, color: Color(0xFF64748B), size: 18),
                          onPressed: () => controller.clearLogs(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Container(
                      height: 180,
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color(0xFF020617),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: ListView.builder(
                        itemCount: state.logs.length,
                        itemBuilder: (context, idx) {
                          final log = state.logs[idx];
                          Color logColor = const Color(0xFFCBD5E1); // slate-300
                          if (log.contains('[RESOLVER]')) {
                            logColor = const Color(0xFFFBBF24); // amber-400
                          } else if (log.contains('[RESOLVER-SUCCESS]')) {
                            logColor = const Color(0xFF34D399); // emerald-400
                          } else if (log.contains('[BOOKING]')) {
                            logColor = const Color(0xFF60A5FA); // blue-400
                          } else if (log.contains('[OPTIMIZATION]')) {
                            logColor = const Color(0xFFF472B6); // pink-400
                          } else if (log.contains('[CAPACITY]')) {
                            logColor = const Color(0xFFFB923C); // orange-400
                          }

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              log,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 12,
                                color: Color(0xFFCBD5E1),
                              ).copyWith(color: logColor),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const AiInsightsCard(
                heading: 'Scheduling & Shift Insights', // .tr() LocaleKeys.
                suggestions: [
                  'Review and resolve scheduling overlaps in real-time.', // .tr() LocaleKeys.
                  'Capacity buffers ensure resilient emergency coverage grids.', // .tr() LocaleKeys.
                  'Shift dispatcher optimizes routes based on caregiver proximity.', // .tr() LocaleKeys.
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
