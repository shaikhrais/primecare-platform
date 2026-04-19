import '../models/scheduler_models.dart';
import '../factory_floor/data_logistics_hub.dart';
import '../../network/result.dart';
import '../../telemetry_service.dart';

class SchedulerService {
  ExecutionGateService? _telemetry;

  void attachTelemetry(ExecutionGateService telemetry) {
    _telemetry = telemetry;
  }

  Future<HorizonSchedule> getHorizonSchedule() async {
    return DataLogisticsHub.fetchAndAssemble<HorizonSchedule>(
      fetchCall: () async {
        // Implementation for real API call would go here
        return _getBootstrapSchedule();
      },
      fallbackBuilder: () => _getBootstrapSchedule(),
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
    try {
      // Simulate API Latency
      await Future.delayed(const Duration(milliseconds: 600));

      // Simulate Server-side conflict check
      final blueprint = _getBootstrapSchedule();
      if (hasConflict(appt, blueprint.appointments, blueprint.resources)) {
        final error = Exception('Conflict detected on server for ${appt.patientName}');
        _telemetry?.failGate(
          ExecutionGateCategory.scheduler,
          'Failed to create appointment (Conflict)',
          error: error,
          metadata: {'apptId': appt.id},
        );
        return Result.failure(error);
      }
      
      _telemetry?.passGate(
        ExecutionGateCategory.scheduler,
        'Appointment created successfully',
        metadata: {'apptId': appt.id, 'patient': appt.patientName},
      );
      return Result.success(null);
    } catch (e, st) {
      _telemetry?.failGate(
        ExecutionGateCategory.scheduler,
        'Failed to create appointment (System)',
        error: e,
        stackTrace: st,
        metadata: {'apptId': appt.id},
      );
      return Result.failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<Result<void>> updateAppointment(Appointment appt) async {
    try {
      await Future.delayed(const Duration(milliseconds: 600));

      // Validation: New slot must be available
      final blueprint = _getBootstrapSchedule();
      final otherApps = blueprint.appointments
          .where((a) => a.id != appt.id)
          .toList();
      if (hasConflict(appt, otherApps, blueprint.resources)) {
        final error = Exception('The new time slot for ${appt.patientName} is not available.');
        _telemetry?.failGate(
          ExecutionGateCategory.scheduler,
          'Failed to update appointment (Conflict)',
          error: error,
          metadata: {'apptId': appt.id},
        );
        return Result.failure(error);
      }
      
      _telemetry?.passGate(
        ExecutionGateCategory.scheduler,
        'Appointment updated successfully',
        metadata: {'apptId': appt.id, 'patient': appt.patientName},
      );
      return Result.success(null);
    } catch (e, st) {
      _telemetry?.failGate(
        ExecutionGateCategory.scheduler,
        'Failed to update appointment (System)',
        error: e,
        stackTrace: st,
        metadata: {'apptId': appt.id},
      );
      return Result.failure(e is Exception ? e : Exception(e.toString()));
    }
  }

  Future<Result<void>> deleteAppointment(String id) async {
    return Result.guardFuture<void>(
      () async {
        await Future.delayed(const Duration(milliseconds: 400));
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
