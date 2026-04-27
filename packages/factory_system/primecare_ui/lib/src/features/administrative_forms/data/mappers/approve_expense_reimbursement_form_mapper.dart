// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/approve_expense_reimbursement_form_view_model.dart';
import '../dtos/approve_expense_reimbursement_form_dto.dart';

class ApproveExpenseReimbursementFormMapper {
  static ApproveExpenseReimbursementFormViewModel fromDto(
    ApproveExpenseReimbursementFormDto dto,
  ) {
    return ApproveExpenseReimbursementFormViewModel(
      expenseId: dto.id ?? '',
      employeeName: dto.employeeName ?? 'Unknown Employee',
      requestedAmount: dto.requestedAmount?.toDouble() ?? 0.0,
      expenseCategory: dto.expenseCategory ?? 'Uncategorized',
      description: dto.description ?? 'No description provided.',
      status: dto.status ?? 'Pending',
    );
  }
}
