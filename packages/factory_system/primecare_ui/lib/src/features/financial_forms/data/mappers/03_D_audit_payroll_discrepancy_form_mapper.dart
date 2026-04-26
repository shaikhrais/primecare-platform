// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_audit_payroll_discrepancy_form_view_model.dart';
import '../dtos/02_M_audit_payroll_discrepancy_form_dto.dart';

class AuditPayrollDiscrepancyFormMapper {
  static AuditPayrollDiscrepancyFormViewModel fromDto(
    AuditPayrollDiscrepancyFormDto dto,
  ) {
    return AuditPayrollDiscrepancyFormViewModel(
      title: dto.raw['title']?.toString() ?? 'auditPayrollDiscrepancyForm',
      metadata: dto.raw,
    );
  }
}
