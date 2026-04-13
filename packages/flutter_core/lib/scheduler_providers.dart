import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';

final schedulerServiceProvider = Provider<SchedulerService>(
  (ref) => SchedulerService(),
);

class HorizonScheduleNotifier extends AsyncNotifier<HorizonSchedule> {
  @override
  Future<HorizonSchedule> build() async {
    final service = ref.watch(schedulerServiceProvider);
    return service.getHorizonSchedule();
  }

  Future<void> addAppointment(Appointment appt) async {
    final oldState = state.value;
    if (oldState == null) return;

    // Optimistic Update
    state = AsyncData(
      oldState.copyWith(appointments: [...oldState.appointments, appt]),
    );

    try {
      await ref.read(schedulerServiceProvider).createAppointment(appt);
    } catch (e) {
      // Rollback on error
      state = AsyncData(oldState);
      rethrow;
    }
  }

  Future<void> updateAppointment(Appointment appt) async {
    final oldState = state.value;
    if (oldState == null) return;

    // Optimistic Update
    state = AsyncData(
      oldState.copyWith(
        appointments: oldState.appointments
            .map((a) => a.id == appt.id ? appt : a)
            .toList(),
      ),
    );

    try {
      await ref.read(schedulerServiceProvider).updateAppointment(appt);
    } catch (e) {
      state = AsyncData(oldState);
      rethrow;
    }
  }

  Future<void> deleteAppointment(String id) async {
    final oldState = state.value;
    if (oldState == null) return;

    // Optimistic Update
    state = AsyncData(
      oldState.copyWith(
        appointments: oldState.appointments.where((a) => a.id != id).toList(),
      ),
    );

    try {
      await ref.read(schedulerServiceProvider).deleteAppointment(id);
    } catch (e) {
      state = AsyncData(oldState);
      rethrow;
    }
  }
}

final horizonScheduleProvider =
    AsyncNotifierProvider<HorizonScheduleNotifier, HorizonSchedule>(() {
      return HorizonScheduleNotifier();
    });

/// Provider for mapping 'Live Pressure' to staff members based on their appointment density.
final staffPressureProvider = Provider.family<SchedulePressure, String>((
  ref,
  staffId,
) {
  final schedule = ref.watch(horizonScheduleProvider).value;
  if (schedule == null) return SchedulePressure.optimal;

  final apptCount = schedule.appointments
      .where((a) => a.staffId == staffId)
      .length;

  if (apptCount > 6) return SchedulePressure.critical;
  if (apptCount > 4) return SchedulePressure.high;
  return SchedulePressure.optimal;
});

/// Proactive AI provider that scans the schedule for anomalies and bottlenecks.
final schedulerAnomalyProvider = Provider<List<AuraEvent>>((ref) {
  final schedule = ref.watch(horizonScheduleProvider).value;
  if (schedule == null) return [];

  final anomalies = <AuraEvent>[];

  // 1. Staff Pressure Anomaly Detection
  for (final staff in schedule.staff) {
    final appts = schedule.appointments
        .where((a) => a.staffId == staff.id)
        .toList();
    if (appts.length > 6) {
      anomalies.add(
        AuraEvent(
          id: 'burnout_${staff.id}',
          type: AuraEventType.workforceEfficiency,
          title: 'Critical Burnout Risk',
          description:
              '${staff.name} has ${appts.length} bookings today. Efficiency may drop below institutional standards.',
          impact: InsightImpact.alert,
          timestamp: DateTime.now(),
          metadata: {'staffId': staff.id, 'count': appts.length},
        ),
      );
    }
  }

  // 2. Resource Hotspot Detection
  for (final res in schedule.resources) {
    final appts = schedule.appointments
        .where((a) => a.resourceId == res.id)
        .toList();
    final totalDuration = appts.fold(0, (sum, a) => sum + a.duration.inMinutes);

    // If resource is used for more than 5 hours (300 mins)
    if (totalDuration > 300) {
      anomalies.add(
        AuraEvent(
          id: 'hotspot_${res.id}',
          type: AuraEventType.occupancySpike,
          title: 'Resource Hotspot',
          description:
              '${res.name} exceeds 5 hours of consecutive utilization. Consider scaling equipment or suite availability.',
          impact: InsightImpact.caution,
          timestamp: DateTime.now(),
          metadata: {'resourceId': res.id, 'duration': totalDuration},
        ),
      );
    }
  }

  return anomalies;
});
