import 'package:primecare_core/primecare_core.dart';

final schedulerServiceProvider = Provider<SchedulerService>(
  (ref) => SchedulerService(),
);

class HorizonScheduleNotifier extends AsyncNotifier<HorizonSchedule> {
  @override
  Future<HorizonSchedule> build() async {
    final telemetry = ref.read(executionGateProvider);
    final service = ref.watch(schedulerServiceProvider);

    telemetry.passGate(
      ExecutionGateCategory.scheduler,
      'Hydrating Horizon Schedule',
    );

    final result = await service.getHorizonSchedule();
    return result.fold(
      (schedule) {
        telemetry.passGate(
          ExecutionGateCategory.scheduler,
          'Horizon Schedule Hydrated',
          metadata: {
            'apptCount': schedule.appointments.length,
            'staffCount': schedule.staff.length,
          },
        );
        return schedule;
      },
      (error) {
        telemetry.failGate(
          ExecutionGateCategory.scheduler,
          'Failed to hydrate Horizon Schedule',
          error: error,
          metadata: {'error': error.toString()},
        );
        // We throw here to ensure AsyncNotifier captures the error in current state,
        // which the UI will handle via .when(error: ...)
        throw error;
      },
    );
  }

  Future<void> addAppointment(Appointment appt) async {
    final telemetry = ref.read(executionGateProvider);
    final oldState = state.value;
    if (oldState == null) return;

    telemetry.passGate(
      ExecutionGateCategory.scheduler,
      'Initiating Optimistic Appointment Add',
      metadata: {'apptId': appt.id},
    );

    // Optimistic Update
    state = AsyncData(
      oldState.copyWith(appointments: [...oldState.appointments, appt]),
    );

    final result = await ref
        .read(schedulerServiceProvider)
        .createAppointment(appt);
    result.fold(
      (_) {
        telemetry.passGate(
          ExecutionGateCategory.scheduler,
          'Appointment Persisted Successfully',
          metadata: {'apptId': appt.id},
        );
      },
      (error) {
        telemetry.failGate(
          ExecutionGateCategory.scheduler,
          'Appointment Persistence Failed - Rolling Back',
          metadata: {'error': error.toString()},
        );
        // Rollback on error
        state = AsyncData(oldState);
      },
    );
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

    final result = await ref
        .read(schedulerServiceProvider)
        .updateAppointment(appt);
    result.fold((_) {}, (_) {
      state = AsyncData(oldState);
    });
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

    final result = await ref
        .read(schedulerServiceProvider)
        .deleteAppointment(id);
    result.fold((_) {}, (_) {
      state = AsyncData(oldState);
    });
  }
}

final horizonScheduleProvider =
    AsyncNotifierProvider<HorizonScheduleNotifier, HorizonSchedule>(() {
      return HorizonScheduleNotifier();
    });

final historicalAnalyticsProvider = Provider.family<double, String>((
  ref,
  staffId,
) {
  try {
    // Deterministic simulation based on ID hash
    final hash = staffId.hashCode.abs();
    // Generate a multiplier between 0.8 and 1.4
    final variance = (hash % 60) / 100.0;
    final result = 0.8 + variance;

    // Bounds validation checkpoint to prevent dynamic scaling errors
    if (result.isNaN || result.isInfinite) return 1.0;
    return result.clamp(0.5, 2.0);
  } catch (e) {
    // Return standard neutral load upon dynamic failure
    return 1.0;
  }
});

final staffPressureProvider = Provider.family<SchedulePressure, String>((
  ref,
  staffId,
) {
  // 1. Reactive Aura Intelligence Override
  final pulse = ref.watch(auraPulseProvider).value;
  if (pulse != null && pulse.metadata?['staffId'] == staffId) {
    if (pulse.impact == InsightImpact.alert) {
      return SchedulePressure.critical;
    } else if (pulse.impact == InsightImpact.caution) {
      return SchedulePressure.high;
    }
  }

  // 2. Fallback to normal capacity checks with Historical Trends
  final schedule = ref.watch(horizonScheduleProvider).value;
  if (schedule == null) return SchedulePressure.optimal;

  final apptCount = schedule.appointments
      .where((a) => a.staffId == staffId)
      .length;

  final historicalMultiplier = ref.watch(historicalAnalyticsProvider(staffId));

  // Safe computation checkpoint
  double effectiveLoad = 0.0;
  try {
    effectiveLoad = apptCount * historicalMultiplier;
    if (effectiveLoad.isNaN || effectiveLoad.isInfinite) {
      ref
          .read(executionGateProvider)
          .failGate(
            ExecutionGateCategory.scheduler,
            'Pressure Computation Invalid - NaN/Infinite detected',
            metadata: {'staffId': staffId, 'load': effectiveLoad},
          );
      effectiveLoad = apptCount.toDouble();
    }
  } catch (e) {
    ref
        .read(executionGateProvider)
        .failGate(
          ExecutionGateCategory.scheduler,
          'Pressure Computation Error',
          metadata: {'staffId': staffId, 'error': e.toString()},
        );
    effectiveLoad = apptCount.toDouble();
  }

  if (effectiveLoad > 6) return SchedulePressure.critical;
  if (effectiveLoad > 4) return SchedulePressure.high;
  return SchedulePressure.optimal;
});

/// Proactive AI provider that scans the schedule for anomalies and bottlenecks.
final schedulerAnomalyProvider = Provider<List<AuraEvent>>((ref) {
  final schedule = ref.watch(horizonScheduleProvider).value;
  if (schedule == null) return [];

  final anomalies = <AuraEvent>[];
  final telemetry = ref.read(executionGateProvider);

  // 1. Staff Pressure Anomaly Detection
  for (final staff in schedule.staff) {
    final appts = schedule.appointments
        .where((a) => a.staffId == staff.id)
        .toList();
    if (appts.length > 6) {
      telemetry.passGate(
        ExecutionGateCategory.aura,
        'Burnout Anomaly Detected',
        metadata: {'staffId': staff.id},
      );
      anomalies.add(
        AuraEvent(
          id: 'burnout_${staff.id}',
          // ... rest of the code ...
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
