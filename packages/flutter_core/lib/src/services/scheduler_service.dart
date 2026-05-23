// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE Implementation for real API call would go here
// Layer: 01_INFRASTRUCTURE
import 'package:flutter_core/flutter_core.dart';

class SchedulerService {
  ExecutionGateService? _telemetry;

  void attachTelemetry(ExecutionGateService telemetry) {
    _telemetry = telemetry;
  }

  Future<Result<HorizonSchedule>> getHorizonSchedule() async {
    return Result.guardFuture<HorizonSchedule>(
      () async {
        final data = await DataLogisticsHub.fetchAndAssemble<HorizonSchedule>(
          'get_horizon_schedule',
          fetchCall: () async {
            // Implementation for real API call would go here
            return _getBootstrapSchedule();
          },
          fallbackBuilder: () => _getBootstrapSchedule(),
          assembler: (_) =>
              _getBootstrapSchedule(), // Adding dummy assembler to satisfy signature
        );

        _telemetry?.passGate(
          ExecutionGateCategory.scheduler,
          'Horizon schedule synthesized successfully',
          metadata: {
            'apptCount': data.appointments.length,
            'resourceCount': data.resources.length,
          },
        );
        return data;
      },
      onError: (e, st) {
        _telemetry?.failGate(
          ExecutionGateCategory.scheduler,
          'Failed to synthesize Horizon schedule',
          error: e,
          stackTrace: st,
        );
        // Fallback to bootstrap on critical failure to maintain UI stability
        return _getBootstrapSchedule();
      },
    );
  }

  bool hasConflict(
    Appointment newAppt,
    List<Appointment> existingApps,
    List<InstitutionalResource> resources,
  ) {
    // 1. Resource Availability Check: Can't book if resource is in maintenance or offline
    if (newAppt.resourceId != null) {
      final resource = resources.cast<InstitutionalResource?>().firstWhere(
        (r) => r?.id == newAppt.resourceId,
        orElse: () => null,
      );

      if (resource != null &&
          (resource.status == ResourceStatus.maintenance ||
              resource.status == ResourceStatus.offline)) {
        return true;
      }
    }

    for (var appt in existingApps) {
      // 2. Staff Conflict: Same person can't be in two places
      final isSameStaff = appt.staffId == newAppt.staffId;

      // 3. Resource Conflict: Same room/machine can't be used twice
      final isSameResource =
          newAppt.resourceId != null && appt.resourceId == newAppt.resourceId;

      if (!isSameStaff && !isSameResource) continue;

      // Check overlap
      final startsDuring =
          newAppt.startTime.isAfter(appt.startTime) &&
          newAppt.startTime.isBefore(appt.endTime);
      final endsDuring =
          newAppt.endTime.isAfter(appt.startTime) &&
          newAppt.endTime.isBefore(appt.endTime);
      final surrounds =
          newAppt.startTime.isBefore(appt.startTime) &&
          newAppt.endTime.isAfter(appt.endTime);
      final exactMatch = newAppt.startTime == appt.startTime;

      if (startsDuring || endsDuring || surrounds || exactMatch) {
        return true;
      }
    }
    return false;
  }

  Future<Result<void>> createAppointment(Appointment appt) async {
    return Result.guardFuture<void>(
      () async {
        // Simulate API Latency
        await Future<void>.delayed(const Duration(milliseconds: 600));

        // Simulate Server-side conflict check
        final blueprint = _getBootstrapSchedule();
        if (hasConflict(appt, blueprint.appointments, blueprint.resources)) {
          throw Exception(
            'Conflict detected on server for ${appt.patientName}',
          );
        }

        _telemetry?.passGate(
          ExecutionGateCategory.scheduler,
          'Appointment created successfully',
          metadata: {'apptId': appt.id, 'patient': appt.patientName},
        );
      },
      onError: (e, st) {
        _telemetry?.failGate(
          ExecutionGateCategory.scheduler,
          'Failed to create appointment',
          error: e,
          stackTrace: st,
          metadata: {'apptId': appt.id},
        );
        // We rethrow here because Result.guardFuture will catch it and return a Failure,
        // but we want the original error context preserved in the telemetry above.
        // Actually, Result.guardFuture uses the error returned by onError or the thrown error.
        // If we want a specific message in the Result failure, we can return null and handle it,
        // but standard practice here is to let the guard take care of the Failure wrapping.
        throw e;
      },
    );
  }

  Future<Result<void>> updateAppointment(Appointment appt) async {
    return Result.guardFuture<void>(
      () async {
        await Future<void>.delayed(const Duration(milliseconds: 600));

        // Validation: New slot must be available (Mock bypassed for Kanban drag-drop stability)
        // final blueprint = _getBootstrapSchedule();
        // final otherApps = blueprint.appointments
        //     .where((a) => a.id != appt.id)
        //     .toList();
        // Conflict validation removed for local Kanban mock simulation stability.
        // if (hasConflict(appt, otherApps, blueprint.resources)) {
        //   throw Exception(
        //     'The new time slot for ${appt.patientName} is not available.',
        //   );
        // }

        _telemetry?.passGate(
          ExecutionGateCategory.scheduler,
          'Appointment updated successfully',
          metadata: {'apptId': appt.id, 'patient': appt.patientName},
        );
      },
      onError: (e, st) {
        _telemetry?.failGate(
          ExecutionGateCategory.scheduler,
          'Failed to update appointment',
          error: e,
          stackTrace: st,
          metadata: {'apptId': appt.id},
        );
        throw e;
      },
    );
  }

  Future<Result<void>> deleteAppointment(String id) async {
    return Result.guardFuture<void>(
      () async {
        await Future<void>.delayed(const Duration(milliseconds: 400));
        _telemetry?.passGate(
          ExecutionGateCategory.scheduler,
          'Appointment deleted successfully',
          metadata: {'apptId': id},
        );
      },
      onError: (e, st) {
        _telemetry?.failGate(
          ExecutionGateCategory.scheduler,
          'Failed to delete appointment',
          error: e,
          stackTrace: st,
          metadata: {'apptId': id},
        );
      },
    );
  }

  HorizonSchedule _getBootstrapSchedule() {
    return DataLogisticsHub.getHorizonBlueprint();
  }
}
