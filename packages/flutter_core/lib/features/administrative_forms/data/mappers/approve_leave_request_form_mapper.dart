import '../../domain/models/approve_leave_request_form_view_model.dart';
import '../dtos/approve_leave_request_form_dto.dart';

class ApproveLeaveRequestFormMapper {
  static ApproveLeaveRequestFormViewModel fromDto(
    ApproveLeaveRequestFormDto dto,
  ) {
    return ApproveLeaveRequestFormViewModel(
      requestId: dto.id ?? '',
      employeeName: dto.employeeName ?? 'Unknown Employee',
      leaveType: dto.leaveType ?? 'General Leave',
      startDate: dto.startDate != null
          ? DateTime.tryParse(dto.startDate!)
          : null,
      endDate: dto.endDate != null ? DateTime.tryParse(dto.endDate!) : null,
      status: dto.status ?? 'Pending',
    );
  }
}
