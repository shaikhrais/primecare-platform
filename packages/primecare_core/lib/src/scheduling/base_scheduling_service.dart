import 'package:primecare_models/primecare_models.dart';
import '../application/base_result_service.dart';

/// Shared conflict decisions; host adapters own transport and persistence.
abstract class BaseSchedulingService extends BaseResultService {
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
}
