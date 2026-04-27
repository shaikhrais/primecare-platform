// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/leave_request_form_view_model.dart';
import '../dtos/leave_request_form_dto.dart';

class LeaveRequestFormMapper {
  static LeaveRequestFormViewModel fromDto(LeaveRequestFormDto dto) {
    return LeaveRequestFormViewModel(
      title: dto.raw['title']?.toString() ?? 'leaveRequestForm',
      metadata: dto.raw,
    );
  }
}
