// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_approve_medication_refill_form_view_model.dart';
import '../dtos/02_M_approve_medication_refill_form_dto.dart';

class ApproveMedicationRefillFormMapper {
  static ApproveMedicationRefillFormViewModel fromDto(
    ApproveMedicationRefillFormDto dto,
  ) {
    return ApproveMedicationRefillFormViewModel(
      requestRefillId: dto.id ?? '',
      patientId: dto.patientId ?? '',
      medicationName: dto.medicationName ?? '',
      dosage: dto.dosage ?? '',
      quantity: dto.quantity ?? 0,
      requestingPhysician: dto.requestingPhysician ?? '',
      status: dto.status ?? 'Pending',
    );
  }

  static ApproveMedicationRefillFormDto toDto(
    ApproveMedicationRefillFormViewModel model,
  ) {
    return ApproveMedicationRefillFormDto(
      id: model.requestRefillId.isEmpty ? null : model.requestRefillId,
      patientId: model.patientId,
      medicationName: model.medicationName,
      dosage: model.dosage,
      quantity: model.quantity,
      requestingPhysician: model.requestingPhysician,
      status: model.status,
    );
  }
}
