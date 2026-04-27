// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/audit_system_logs_form_view_model.dart';
import '../dtos/audit_system_logs_form_dto.dart';

class AuditSystemLogsFormMapper {
  static AuditSystemLogsFormViewModel fromDto(AuditSystemLogsFormDto dto) {
    return AuditSystemLogsFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditSystemLogsForm',
      metadata: dto.raw,
    );
  }
}
