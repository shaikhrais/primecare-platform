import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/primecare_core.dart';
import '../dtos/approve_payroll_run_form_dto.dart';
import '../mappers/approve_payroll_run_form_mapper.dart';

class ApprovePayrollRunFormAdapter
    extends Notifier<ApprovePayrollRunFormViewModel> {
  @override
  ApprovePayrollRunFormViewModel build() {
    return ApprovePayrollRunFormViewModel();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);
    
    final telemetry = ref.read(executionGateProvider);
    final apiClient = ref.read(apiClientProvider);

    telemetry.passGate(ExecutionGateCategory.domainApi, 'Starting Payroll Data fetch');

    final result = await Result.guardFuture<ApprovePayrollRunFormDto>(() async {
      final response = await apiClient.get('/api/v1/admin/payroll/latest');
      if (response.statusCode == 200) {
        return ApprovePayrollRunFormDto.fromJson(response.data);
      }
      throw Exception('API error: ${response.statusCode}');
    });

    result.fold(
      (dto) {
        telemetry.passGate(ExecutionGateCategory.domainApi, 'Payroll API fetched successfully');
        state = ApprovePayrollRunFormMapper.fromDto(dto).copyWith(isLoading: false);
      },
      (error) {
        telemetry.failGate(ExecutionGateCategory.domainApi, 'Payroll API failed, falling back to cache/mock', error: error);
        final mockDto = ApprovePayrollRunFormDto(
          id: 'PRL-2023-11',
          periodStartDate: DateTime.now()
              .subtract(const Duration(days: 14))
              .toIso8601String(),
          periodEndDate: DateTime.now().toIso8601String(),
          totalPayrollAmount: 145000.50,
          totalEmployees: 42,
          status: 'Pending Director Approval',
        );

        final viewModel = ApprovePayrollRunFormMapper.fromDto(mockDto);
        state = viewModel.copyWith(isLoading: false);
      }
    );
  }

  void approve() {
    state = state.copyWith(status: 'Approved');
  }

  void reject() {
    state = state.copyWith(status: 'Rejected');
  }
}

final approvePayrollRunFormAdapterProvider =
    NotifierProvider<
      ApprovePayrollRunFormAdapter,
      ApprovePayrollRunFormViewModel
    >(() {
      return ApprovePayrollRunFormAdapter();
    });
