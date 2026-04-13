import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/approve_payroll_run_form_view_model.dart';
import '../dtos/approve_payroll_run_form_dto.dart';
import '../mappers/approve_payroll_run_form_mapper.dart';

class ApprovePayrollRunFormAdapter extends Notifier<ApprovePayrollRunFormViewModel> {
  @override
  ApprovePayrollRunFormViewModel build() {
    return ApprovePayrollRunFormViewModel();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);

    try {
      // TODO: Prisma API binding
      await Future.delayed(const Duration(milliseconds: 500));

      final mockDto = ApprovePayrollRunFormDto(
        id: 'PRL-2023-11',
        periodStartDate: DateTime.now().subtract(const Duration(days: 14)).toIso8601String(),
        periodEndDate: DateTime.now().toIso8601String(),
        totalPayrollAmount: 145000.50,
        totalEmployees: 42,
        status: 'Pending Director Approval',
      );

      final viewModel = ApprovePayrollRunFormMapper.fromDto(mockDto);
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

final approvePayrollRunFormAdapterProvider =
    NotifierProvider<ApprovePayrollRunFormAdapter, ApprovePayrollRunFormViewModel>(() {
  return ApprovePayrollRunFormAdapter();
});
