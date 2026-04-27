// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/schedule_clinical_audit_form_view_model.dart';
import '../dtos/schedule_clinical_audit_form_dto.dart';

class ScheduleClinicalAuditFormMapper {
  static ScheduleClinicalAuditFormViewModel fromDto(
    ScheduleClinicalAuditFormDto dto,
  ) {
    return ScheduleClinicalAuditFormViewModel(
      title: dto.raw['title']?.toString() ?? 'scheduleClinicalAuditForm',
      metadata: dto.raw,
    );
  }
}
