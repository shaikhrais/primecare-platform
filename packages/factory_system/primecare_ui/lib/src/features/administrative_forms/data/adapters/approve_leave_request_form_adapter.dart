// Layer: 01_INFRASTRUCTURE
import 'package:primecare_adapters/primecare_adapters.dart';
import '../../domain/models/approve_leave_request_form_view_model.dart';
import '../dtos/approve_leave_request_form_dto.dart';
import '../mappers/approve_leave_request_form_mapper.dart';

class ApproveLeaveRequestFormAdapter
    extends Notifier<ApproveLeaveRequestFormViewModel> {
  @override
  ApproveLeaveRequestFormViewModel build() {
    return ApproveLeaveRequestFormViewModel();
  }

  Future<void> loadData() async {
    state = state.copyWith(isLoading: true);

    try {
      // Pull dynamic node from the hardened seeding layer
      final node = DataLogisticsHub.getInstitutionalNode(
        'leaveRequestNode',
        'REQ-12345',
      );

      final mockDto = ApproveLeaveRequestFormDto(
        id: (node?['id'] as String?) ?? 'REQ-12345',
        employeeName: (node?['employeeName'] as String?) ?? 'Jane Doe',
        leaveType: (node?['type'] as String?) ?? 'Vacation',
        startDate:
            (node?['startDate'] as String?) ??
            DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        endDate:
            (node?['endDate'] as String?) ??
            DateTime.now().add(const Duration(days: 14)).toIso8601String(),
        status: (node?['status'] as String?) ?? 'Pending HR Approval',
      );

      final viewModel = ApproveLeaveRequestFormMapper.fromDto(mockDto);
      state = viewModel.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error accordingly
    }
  }

  void approve() {
    state = state.copyWith(status: 'Approved');
    // NOTE: Invoke Domain Provider to POST approval back to API when available
  }

  void reject() {
    state = state.copyWith(status: 'Rejected');
    // NOTE: Invoke Domain Provider to POST rejection back to API when available
  }
}

final approveLeaveRequestFormAdapterProvider =
    NotifierProvider<
      ApproveLeaveRequestFormAdapter,
      ApproveLeaveRequestFormViewModel
    >(() {
      return ApproveLeaveRequestFormAdapter();
    });
