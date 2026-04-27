// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/approve_leave_request_form_view_model.dart';
import '../dtos/approve_leave_request_form_dto.dart';

class ApproveLeaveRequestFormMapper {
  static ApproveLeaveRequestFormViewModel fromDto(
    ApproveLeaveRequestFormDto dto,
  ) {
    return ApproveLeaveRequestFormViewModel(
      title: dto.raw['title']?.toString() ?? 'approveLeaveRequestForm',
      metadata: dto.raw,
    );
  }
}
