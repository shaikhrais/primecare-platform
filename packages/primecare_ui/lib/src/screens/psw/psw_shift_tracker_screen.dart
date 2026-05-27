// Governance - Category: view | Purpose: UI Screen component rendering the Psw Shift Tracker Screen workspace interface.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class PswShiftTrackerState {
  final bool isClockedIn;
  final DateTime? clockInTime;
  final Duration activeDuration;
  final bool isSyncing;
  final List<Map<String, dynamic>> todayShifts;
  final String? activeShiftId;

  const PswShiftTrackerState({
    this.isClockedIn = false,
    this.clockInTime,
    this.activeDuration = Duration.zero,
    this.isSyncing = false,
    this.todayShifts = const [],
    this.activeShiftId,
  });

  PswShiftTrackerState copyWith({
    bool? isClockedIn,
    DateTime? clockInTime,
    Duration? activeDuration,
    bool? isSyncing,
    List<Map<String, dynamic>>? todayShifts,
    String? activeShiftId,
  }) {
    return PswShiftTrackerState(
      isClockedIn: isClockedIn ?? this.isClockedIn,
      clockInTime: clockInTime ?? this.clockInTime,
      activeDuration: activeDuration ?? this.activeDuration,
      isSyncing: isSyncing ?? this.isSyncing,
      todayShifts: todayShifts ?? this.todayShifts,
      activeShiftId: activeShiftId ?? this.activeShiftId,
    );
  }
}

// --- Controller (Notifier) ---
class PswShiftTrackerController extends StateNotifier<PswShiftTrackerState> {
  Timer? _timer;
  final Ref _ref;

  PswShiftTrackerController(this._ref)
      : super(
          PswShiftTrackerState(
            todayShifts: [
              {
                'id': 'SH-001',
                'client': 'Margaret Thompson',
                'time': '08:00 AM - 12:00 PM',
                'address': '451 Elm Ave, Toronto',
                'status': 'completed',
                'tasksCompleted': 4,
                'tasksTotal': 4,
              },
              {
                'id': 'SH-002',
                'client': 'Arthur Pendelton',
                'time': '01:30 PM - 04:30 PM',
                'address': '89 Queen St W, Toronto',
                'status': 'pending',
                'tasksCompleted': 0,
                'tasksTotal': 5,
              },
              {
                'id': 'SH-003',
                'client': 'Eleanor Vance',
                'time': '06:00 PM - 08:30 PM',
                'address': '12 Bayview Rd, Richmond Hill',
                'status': 'pending',
                'tasksCompleted': 0,
                'tasksTotal': 3,
              },
            ],
          ),
        );

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void clockIn(String shiftId) {
    if (state.isClockedIn) return;

    final now = DateTime.now();
    state = state.copyWith(
      isClockedIn: true,
      clockInTime: now,
      activeShiftId: shiftId,
      activeDuration: Duration.zero,
    );

    // Dynamic timer increment
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        activeDuration: DateTime.now().difference(now),
      );
    });

    // Logging telemetry events via execution gate
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/psw/shift-tracker',
            eventType: 'psw_clock_in',
            metadata: {'shiftId': shiftId, 'timestamp': now.toIso8601String()},
          );
    } catch (_) {}
  }

  void clockOut() {
    if (!state.isClockedIn) return;

    _timer?.cancel();
    final clockOutTime = DateTime.now();

    // Map through the shifts and mark the active one as completed
    final updatedShifts = state.todayShifts.map((shift) {
      if (shift['id'] == state.activeShiftId) {
        return {
          ...shift,
          'status': 'completed',
          'tasksCompleted': shift['tasksTotal'],
        };
      }
      return shift;
    }).toList();

    state = state.copyWith(
      isClockedIn: false,
      clockInTime: null,
      activeShiftId: null,
      activeDuration: Duration.zero,
      todayShifts: updatedShifts,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/psw/shift-tracker',
            eventType: 'psw_clock_out',
            metadata: {
              'timestamp': clockOutTime.toIso8601String(),
            },
          );
    } catch (_) {}
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }
}

// --- Provider ---
final pswShiftTrackerControllerProvider =
    StateNotifierProvider<PswShiftTrackerController, PswShiftTrackerState>((ref) {
  return PswShiftTrackerController(ref);
});

// --- View ---
class PswShiftTrackerScreen extends GovernedConsumerWidget {
  const PswShiftTrackerScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(pswShiftTrackerControllerProvider);
    final controller = ref.read(pswShiftTrackerControllerProvider.notifier);
    final theme = context.theme;

    return Scaffold(
      key: const Key('pswshifttracker-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('pswshifttracker-title'),
          'Shift Tracker',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
      ),
      body: Semantics(
        label: 'data-cy:pswshifttracker-screen',
        child: SingleChildScrollView(
        key: const Key('pswshifttracker-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('pswshifttracker-btn-1'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),

            // Active Shift Card / Clock In/Out Center
            _buildActiveTracker(context, state, controller),
            const SizedBox(height: 24),
            // Today's Care Timeline
            Text(
              "Today's Shifts",
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
            const SizedBox(height: 12),
            ...state.todayShifts.map((shift) => _buildShiftCard(context, shift, state, controller)),
          ],
        ),),
    ),
    );
  }

  Widget _buildActiveTracker(
    BuildContext context,
    PswShiftTrackerState state,
    PswShiftTrackerController controller,
  ) {
    final theme = context.theme;

    if (!state.isClockedIn) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(theme.radiusMd),
          border: Border.all(color: theme.colors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Column(
          children: [
            Icon(LucideIcons.clock, size: 48, color: theme.colors.primary.withValues(alpha: 0.7)),
            const SizedBox(height: 16),
            Text(
              'Not Clocked In',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Select an upcoming shift below to begin recording your hours and tasks.',
              textAlign: TextAlign.center,
              style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    // When Clocked In
    final activeShift = state.todayShifts.firstWhere(
      (s) => s['id'] == state.activeShiftId,
      orElse: () => <String, dynamic>{},
    );

    final durationString = _formatDuration(state.activeDuration);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            theme.colors.primary,
            theme.colors.primary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(theme.radiusMd),
        boxShadow: [
          BoxShadow(
            color: theme.colors.primary.withValues(alpha: 0.2),
            blurRadius: 12,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.radio, size: 14, color: Colors.redAccent),
                    const SizedBox(width: 6),
                    Text(
                      'ACTIVE SHIFT',
                      style: theme.typography.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'ID: ${activeShift['id']}',
                style: theme.typography.labelSmall.copyWith(color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            durationString,
            style: theme.typography.h1.copyWith(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            'Active Care Duration',
            style: theme.typography.bodySmall.copyWith(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Divider(color: Colors.white30, height: 1),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(LucideIcons.user, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Text(
                (activeShift['client'] as String?) ?? '',
                style: theme.typography.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(LucideIcons.mapPin, color: Colors.white70, size: 18),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  (activeShift['address'] as String?) ?? '',
                  style: theme.typography.bodyMedium.copyWith(color: Colors.white.withOpacity(0.9)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: theme.colors.primary,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => controller.clockOut(),
              icon: const Icon(LucideIcons.logOut),
              label: Text(
                'Complete Shift & Clock Out',
                style: theme.typography.button.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftCard(
    BuildContext context,
    Map<String, dynamic> shift,
    PswShiftTrackerState state,
    PswShiftTrackerController controller,
  ) {
    final theme = context.theme;
    final isCompleted = shift['status'] == 'completed';
    final isThisActive = state.activeShiftId == shift['id'];

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colors.surface,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(
          color: isThisActive
              ? theme.colors.primary
              : theme.colors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                (shift['time'] as String?) ?? '',
                style: theme.typography.bodyMedium.copyWith(
                  color: theme.colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withValues(alpha: 0.1)
                      : isThisActive
                          ? theme.colors.primary.withValues(alpha: 0.1)
                          : theme.colors.border,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  isCompleted
                      ? 'Completed'
                      : isThisActive
                          ? 'In Progress'
                          : 'Upcoming',
                  style: theme.typography.labelSmall.copyWith(
                    color: isCompleted
                        ? Colors.green
                        : isThisActive
                            ? theme.colors.primary
                            : theme.colors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            (shift['client'] as String?) ?? '',
            style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Icon(LucideIcons.mapPin, size: 14, color: theme.colors.onSurfaceVariant),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  (shift['address'] as String?) ?? '',
                  style: theme.typography.bodyMedium.copyWith(
                    color: theme.colors.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(LucideIcons.checkSquare, size: 16, color: theme.colors.primary),
                  const SizedBox(width: 6),
                  Text(
                    'Tasks: ${shift['tasksCompleted']}/${shift['tasksTotal']}',
                    style: theme.typography.bodySmall.copyWith(
                      color: theme.colors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              if (!isCompleted && !state.isClockedIn)
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                  onPressed: () => controller.clockIn(shift['id'] as String),
                  icon: const Icon(LucideIcons.play, size: 14),
                  label: const Text('Clock In'),
                ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    final hours = d.inHours.toString().padLeft(2, '0');
    final minutes = (d.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }
}
