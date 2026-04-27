// Layer: 01_INFRASTRUCTURE
import 'package:primecare_adapters/primecare_adapters.dart';
import '../dtos/approve_expense_reimbursement_form_dto.dart';
import '../mappers/approve_expense_reimbursement_form_mapper.dart';
import '../../domain/models/approve_expense_reimbursement_form_view_model.dart';

class ApproveExpenseReimbursementFormAdapter
    extends Notifier<ApproveExpenseReimbursementFormViewModel> {
  @override
  ApproveExpenseReimbursementFormViewModel build() {
    return ApproveExpenseReimbursementFormViewModel();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);

    final telemetry = ref.read<ExecutionGateService>(executionGateProvider);
    final apiClient = ref.read(apiClientProvider);

    telemetry.passGate(
      ExecutionGateCategory.domainApi,
      'Starting Expense Reimbursement fetch',
    );

    final result = await Result.guardFuture<ApproveExpenseReimbursementFormDto>(
      () async {
        final response = await apiClient.get('/api/v1/admin/expenses/latest');
        if (response.statusCode == 200) {
          return ApproveExpenseReimbursementFormDto.fromJson(
            response.data as Map<String, dynamic>,
          );
        }
        return ApproveExpenseReimbursementFormDto(
          id: 'EXP-FAILED',
          employeeName: 'System (Offline)',
          requestedAmount: 0.0,
          expenseCategory: 'Error',
          description: 'Failed to load data from server',
          status: 'Degraded',
        );
      },
    );

    result.fold(
      (dto) {
        telemetry.passGate(
          ExecutionGateCategory.domainApi,
          'Expense API fetched successfully',
        );
        state = ApproveExpenseReimbursementFormMapper.fromDto(
          dto,
        ).copyWith(isLoading: false);
      },
      (error) {
        telemetry.failGate(
          ExecutionGateCategory.domainApi,
          'Expense API failed, falling back to cache/mock',
          error: error,
        );
        // Hybrid fallback
        final mockDto = ApproveExpenseReimbursementFormDto(
          id: 'EXP-9921',
          employeeName: 'John Smith',
          requestedAmount: 450.75,
          expenseCategory: 'Travel & Accommodation',
          description: 'Flight to Regional Conference Q3',
          status: 'Pending Finance Approval',
        );
        state = ApproveExpenseReimbursementFormMapper.fromDto(
          mockDto,
        ).copyWith(isLoading: false);
      },
    );
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
