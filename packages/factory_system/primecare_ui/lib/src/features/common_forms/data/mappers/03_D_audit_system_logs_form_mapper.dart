// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_audit_system_logs_form_view_model.dart';
import '../dtos/02_M_audit_system_logs_form_dto.dart';

class AuditSystemLogsFormMapper {
  static AuditSystemLogsFormViewModel fromDto(AuditSystemLogsFormDto dto) {
    return AuditSystemLogsFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditSystemLogsForm',
      metadata: dto.raw,
    );
  }
}

