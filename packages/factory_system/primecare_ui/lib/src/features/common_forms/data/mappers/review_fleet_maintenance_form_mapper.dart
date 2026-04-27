// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/review_fleet_maintenance_form_view_model.dart';
import '../dtos/review_fleet_maintenance_form_dto.dart';

class ReviewFleetMaintenanceFormMapper {
  static ReviewFleetMaintenanceFormViewModel fromDto(
    ReviewFleetMaintenanceFormDto dto,
  ) {
    return ReviewFleetMaintenanceFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewFleetMaintenanceForm',
      metadata: dto.raw,
    );
  }
}
