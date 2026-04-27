// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/log_clinical_incident_form_view_model.dart';
import '../dtos/log_clinical_incident_form_dto.dart';

class LogClinicalIncidentFormMapper {
  static LogClinicalIncidentFormViewModel fromDto(
    LogClinicalIncidentFormDto dto,
  ) {
    return LogClinicalIncidentFormViewModel(
      title: dto.raw['title']?.toString() ?? 'logClinicalIncidentForm',
      metadata: dto.raw,
    );
  }
}
