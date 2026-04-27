// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/review_clinical_incident_form_view_model.dart';
import '../dtos/review_clinical_incident_form_dto.dart';

class ReviewClinicalIncidentFormMapper {
  static ReviewClinicalIncidentFormViewModel fromDto(
    ReviewClinicalIncidentFormDto dto,
  ) {
    return ReviewClinicalIncidentFormViewModel(
      title: dto.raw['title']?.toString() ?? 'reviewClinicalIncidentForm',
      metadata: dto.raw,
    );
  }
}
