import '../models/scheduler_models.dart';
import '../factory_floor/data_logistics_hub.dart';

class SchedulerService {
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

  Future<void> createAppointment(Appointment appt) async {
    // Simulate API Latency
    await Future.delayed(const Duration(milliseconds: 600));

    // Simulate Server-side conflict check
    final blueprint = _getBootstrapSchedule();
    if (hasConflict(appt, blueprint.appointments, blueprint.resources)) {
      throw Exception('Conflict detected on server for ${appt.patientName}');
    }
  }

  Future<void> updateAppointment(Appointment appt) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // Validation: New slot must be available
    final blueprint = _getBootstrapSchedule();
    final otherApps = blueprint.appointments
        .where((a) => a.id != appt.id)
        .toList();
    if (hasConflict(appt, otherApps, blueprint.resources)) {
      throw Exception(
        'The new time slot for ${appt.patientName} is not available.',
      );
    }
  }

  Future<void> deleteAppointment(String id) async {
    await Future.delayed(const Duration(milliseconds: 400));
  }

  HorizonSchedule _getBootstrapSchedule() {
    return DataLogisticsHub.getHorizonBlueprint();
  }
}
