// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_audit_payroll_discrepancy_form_view_model.dart';
import '../dtos/02_M_audit_payroll_discrepancy_form_dto.dart';

class AuditPayrollDiscrepancyFormMapper {
  static AuditPayrollDiscrepancyFormViewModel toViewModel(
    AuditPayrollDiscrepancyFormDto dto,
  ) {
    return AuditPayrollDiscrepancyFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static AuditPayrollDiscrepancyFormDto toDto(
    AuditPayrollDiscrepancyFormViewModel viewModel,
  ) {
    return AuditPayrollDiscrepancyFormDto(rawData: viewModel.data);
  }
}
