import '../../domain/models/leave_request_form_view_model.dart';
import '../dtos/leave_request_form_dto.dart';

class LeaveRequestFormMapper {
  static LeaveRequestFormViewModel toViewModel(LeaveRequestFormDto dto) {
    return LeaveRequestFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static LeaveRequestFormDto toDto(LeaveRequestFormViewModel viewModel) {
    return LeaveRequestFormDto(rawData: viewModel.data);
  }
}
