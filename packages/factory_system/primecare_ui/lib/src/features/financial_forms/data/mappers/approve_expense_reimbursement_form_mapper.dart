// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/approve_expense_reimbursement_form_view_model.dart';
import '../dtos/approve_expense_reimbursement_form_dto.dart';

class ApproveExpenseReimbursementFormMapper {
  static ApproveExpenseReimbursementFormViewModel fromDto(
    ApproveExpenseReimbursementFormDto dto,
  ) {
    return ApproveExpenseReimbursementFormViewModel(
      title: dto.raw['title']?.toString() ?? 'approveExpenseReimbursementForm',
      metadata: dto.raw,
    );
  }
}
