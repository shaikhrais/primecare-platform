// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/approve_payroll_run_form_view_model.dart';
import '../dtos/approve_payroll_run_form_dto.dart';

class ApprovePayrollRunFormMapper {
  static ApprovePayrollRunFormViewModel fromDto(ApprovePayrollRunFormDto dto) {
    return ApprovePayrollRunFormViewModel(
      title: dto.raw['title']?.toString() ?? 'approvePayrollRunForm',
      metadata: dto.raw,
    );
  }
}
