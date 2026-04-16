import '../../domain/models/patient_intake_form_view_model.dart';
import '../dtos/patient_intake_form_dto.dart';

class PatientIntakeFormMapper {
  static PatientIntakeFormViewModel fromDto(PatientIntakeFormDto dto) {
    return PatientIntakeFormViewModel(
      patientId: dto.id ?? '',
      firstName: dto.firstName ?? '',
      lastName: dto.lastName ?? '',
      dateOfBirth: dto.dateOfBirth != null
          ? DateTime.tryParse(dto.dateOfBirth!)
          : null,
      healthCardNumber: dto.healthCardNumber ?? '',
      primaryDiagnosis: dto.primaryDiagnosis ?? '',
      allergies: dto.allergies ?? [],
      status: dto.status ?? 'Draft',
    );
  }

  static PatientIntakeFormDto toDto(PatientIntakeFormViewModel model) {
    return PatientIntakeFormDto(
      id: model.patientId.isEmpty ? null : model.patientId,
      firstName: model.firstName,
      lastName: model.lastName,
      dateOfBirth: model.dateOfBirth?.toIso8601String(),
      healthCardNumber: model.healthCardNumber,
      primaryDiagnosis: model.primaryDiagnosis,
      allergies: model.allergies,
      status: model.status,
    );
  }
}
