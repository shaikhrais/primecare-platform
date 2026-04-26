// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_audit_compliance_form_view_model.dart';
import '../dtos/02_M_audit_compliance_form_dto.dart';

class AuditComplianceFormMapper {
  static AuditComplianceFormViewModel fromDto(AuditComplianceFormDto dto) {
    return AuditComplianceFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditComplianceForm',
      metadata: dto.raw,
    );
  }
}
