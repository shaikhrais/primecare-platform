import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/approve_expense_reimbursement_form_view_model.dart';
import '../dtos/approve_expense_reimbursement_form_dto.dart';
import '../mappers/approve_expense_reimbursement_form_mapper.dart';

class ApproveExpenseReimbursementFormAdapter
    extends Notifier<ApproveExpenseReimbursementFormViewModel> {
  @override
  ApproveExpenseReimbursementFormViewModel build() {
    return ApproveExpenseReimbursementFormViewModel();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);

    try {
      // TODO: Prisma API binding
      await Future.delayed(const Duration(milliseconds: 500));

      final mockDto = ApproveExpenseReimbursementFormDto(
        id: 'EXP-9921',
        employeeName: 'John Smith',
        requestedAmount: 450.75,
        expenseCategory: 'Travel & Accommodation',
        description: 'Flight to Regional Conference Q3',
        status: 'Pending Finance Approval',
      );

      final viewModel = ApproveExpenseReimbursementFormMapper.fromDto(mockDto);
      state = viewModel.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  void approve() {
    state = state.copyWith(status: 'Approved');
  }

  void reject() {
    state = state.copyWith(status: 'Rejected');
  }
}

final approveExpenseReimbursementFormAdapterProvider =
    NotifierProvider<
      ApproveExpenseReimbursementFormAdapter,
      ApproveExpenseReimbursementFormViewModel
    >(() {
      return ApproveExpenseReimbursementFormAdapter();
    });
