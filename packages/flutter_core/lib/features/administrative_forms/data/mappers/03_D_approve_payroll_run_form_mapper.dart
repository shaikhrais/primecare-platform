// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_approve_payroll_run_form_view_model.dart';
import '../dtos/02_M_approve_payroll_run_form_dto.dart';

class ApprovePayrollRunFormMapper {
  static ApprovePayrollRunFormViewModel fromDto(ApprovePayrollRunFormDto dto) {
    return ApprovePayrollRunFormViewModel(
      payrollRunId: dto.id ?? '',
      periodStartDate: dto.periodStartDate != null
          ? DateTime.tryParse(dto.periodStartDate!)
          : null,
      periodEndDate: dto.periodEndDate != null
          ? DateTime.tryParse(dto.periodEndDate!)
          : null,
      totalPayrollAmount: dto.totalPayrollAmount?.toDouble() ?? 0.0,
      totalEmployees: dto.totalEmployees ?? 0,
      status: dto.status ?? 'Pending',
    );
  }
}
