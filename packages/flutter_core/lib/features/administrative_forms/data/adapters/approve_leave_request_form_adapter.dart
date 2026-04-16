import 'package:flutter_riverpod/flutter_riverpod.dart';
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
      // TODO: Prisma API binding
      await Future.delayed(const Duration(milliseconds: 500));

      final mockDto = ApproveLeaveRequestFormDto(
        id: 'REQ-12345',
        employeeName: 'Jane Doe',
        leaveType: 'Vacation',
        startDate: DateTime.now()
            .add(const Duration(days: 7))
            .toIso8601String(),
        endDate: DateTime.now().add(const Duration(days: 14)).toIso8601String(),
        status: 'Pending HR Approval',
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
    // TODO: POST approval back to API
  }

  void reject() {
    state = state.copyWith(status: 'Rejected');
    // TODO: POST rejection back to API
  }
}

final approveLeaveRequestFormAdapterProvider =
    NotifierProvider<
      ApproveLeaveRequestFormAdapter,
      ApproveLeaveRequestFormViewModel
    >(() {
      return ApproveLeaveRequestFormAdapter();
    });
