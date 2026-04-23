// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_patient_intake_form_view_model.dart';
import '../dtos/02_M_patient_intake_form_dto.dart';

class PatientIntakeFormMapper {
  static PatientIntakeFormViewModel fromDto(PatientIntakeFormDto dto) {
    return PatientIntakeFormViewModel(
      title: dto.raw['title']?.toString() ?? 'patientIntakeForm',
      metadata: dto.raw,
    );
  }
}

