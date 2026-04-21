// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_audit_override_form_view_model.dart';
import '../dtos/02_M_audit_override_form_dto.dart';

class AuditOverrideFormMapper {
  static AuditOverrideFormViewModel fromDto(AuditOverrideFormDto dto) {
    return AuditOverrideFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditOverrideForm',
      metadata: dto.raw,
    );
  }
}

