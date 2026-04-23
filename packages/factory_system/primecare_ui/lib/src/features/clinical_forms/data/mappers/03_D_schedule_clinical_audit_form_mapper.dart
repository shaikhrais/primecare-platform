// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_schedule_clinical_audit_form_view_model.dart';
import '../dtos/02_M_schedule_clinical_audit_form_dto.dart';

class ScheduleClinicalAuditFormMapper {
  static ScheduleClinicalAuditFormViewModel fromDto(ScheduleClinicalAuditFormDto dto) {
    return ScheduleClinicalAuditFormViewModel(
      title: dto.raw['title']?.toString() ?? 'scheduleClinicalAuditForm',
      metadata: dto.raw,
    );
  }
}

