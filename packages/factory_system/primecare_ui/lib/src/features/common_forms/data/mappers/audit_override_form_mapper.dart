// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/audit_override_form_view_model.dart';
import '../dtos/audit_override_form_dto.dart';

class AuditOverrideFormMapper {
  static AuditOverrideFormViewModel fromDto(AuditOverrideFormDto dto) {
    return AuditOverrideFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditOverrideForm',
      metadata: dto.raw,
    );
  }
}
