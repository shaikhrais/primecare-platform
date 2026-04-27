// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/schedule_facility_maintenance_form_view_model.dart';
import '../dtos/schedule_facility_maintenance_form_dto.dart';

class ScheduleFacilityMaintenanceFormMapper {
  static ScheduleFacilityMaintenanceFormViewModel fromDto(
    ScheduleFacilityMaintenanceFormDto dto,
  ) {
    return ScheduleFacilityMaintenanceFormViewModel(
      title: dto.raw['title']?.toString() ?? 'scheduleFacilityMaintenanceForm',
      metadata: dto.raw,
    );
  }
}
