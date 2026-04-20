// ignore_for_file: avoid_dynamic_calls, argument_type_not_assignable, inference_failure_on_instance_creation, strict_raw_type, inference_failure_on_function_invocation, undefined_identifier, inference_failure_on_collection_literal, undefined_named_parameter, return_of_invalid_type, prefer_single_quotes, invalid_assignment, non_type_as_type_argument
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/approve_leave_request_form_view_model.dart';
import '../dtos/approve_leave_request_form_dto.dart';
import '../mappers/approve_leave_request_form_mapper.dart';
import '../../../../src/factory_floor/data_logistics_hub.dart';

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
        id: node?['id'] ?? 'REQ-12345',
        employeeName: node?['employeeName'] ?? 'Jane Doe',
        leaveType: node?['type'] ?? 'Vacation',
        startDate:
            node?['startDate'] ??
            DateTime.now().add(const Duration(days: 7)).toIso8601String(),
        endDate:
            node?['endDate'] ??
            DateTime.now().add(const Duration(days: 14)).toIso8601String(),
        status: node?['status'] ?? 'Pending HR Approval',
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
