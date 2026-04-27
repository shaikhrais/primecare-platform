// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/audit_security_compliance_form_view_model.dart';
import '../dtos/audit_security_compliance_form_dto.dart';

class AuditSecurityComplianceFormMapper {
  static AuditSecurityComplianceFormViewModel fromDto(
    AuditSecurityComplianceFormDto dto,
  ) {
    return AuditSecurityComplianceFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditSecurityComplianceForm',
      metadata: dto.raw,
    );
  }
}
