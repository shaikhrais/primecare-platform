// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_audit_global_education_form_view_model.dart';
import '../dtos/02_M_audit_global_education_form_dto.dart';

class AuditGlobalEducationFormMapper {
  static AuditGlobalEducationFormViewModel fromDto(
    AuditGlobalEducationFormDto dto,
  ) {
    return AuditGlobalEducationFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditGlobalEducationForm',
      metadata: dto.raw,
    );
  }
}
