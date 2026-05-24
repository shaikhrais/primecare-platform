// Governance - Category: view | Purpose: UI Screen component rendering the Scheduler Dashboard Screen workspace interface.
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
    final roleBase = 'SchedulerDashboardScreen'.replaceAll('DashboardScreen', '').replaceAll('Screen', '');

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary),
            onPressed: () => controller.addLog('Manual refresh triggered.'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GovDashboardHero(
              title: state.title,
              roleName: '$roleBase Dashboard',
              description: 'Welcome to your governed operation center. Review key performance indicators, live telemetry logs, and compliance standings.',
              onRefresh: () => controller.addLog('Dashboard telemetry synchronized.'),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: GovMetricCard(
                    title: 'Active Operations',
                    value: 'Active',
                    trendLabel: 'Optimal productivity',
                    progress: 0.92,
                    icon: LucideIcons.activity,
                    brandColor: theme.colors.primary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GovMetricCard(
                    title: 'Security Clearance',
                    value: 'Level 4 Approved',
                    trendLabel: 'Zero exceptions logged',
                    progress: 1.0,
                    icon: LucideIcons.shieldCheck,
                    brandColor: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            GovTelemetryChart(
              title: 'Hourly Core Telemetry',
              dataPoints: const [75, 82, 80, 94, 91, 98],
              labels: const ['09:00', '10:00', '11:00', '12:00', '13:00', '14:00'],
              accentColor: theme.colors.primary,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
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
                    'Operational Audit Logs',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...state.logs.map((log) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '• ',
                              style: TextStyle(color: theme.colors.primary, fontWeight: FontWeight.bold),
                            ),
                            Expanded(
                              child: Text(
                                log,
                                style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 16),
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
                      onPressed: state.isLoading ? null : () => controller.runComplianceScan(),
                      child: state.isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation(Colors.white),
                              ),
                            )
                          : Text(
                              'Execute Operational Audit Scan',
                              style: theme.typography.button.copyWith(color: Colors.white),
                            ),
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
