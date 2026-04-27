// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/patient_intake_form_view_model.dart';
import '../dtos/patient_intake_form_dto.dart';

class PatientIntakeFormMapper {
  static PatientIntakeFormViewModel fromDto(PatientIntakeFormDto dto) {
    return PatientIntakeFormViewModel(
      title: dto.raw['title']?.toString() ?? 'patientIntakeForm',
      metadata: dto.raw,
    );
  }
}
