// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_leave_request_form_view_model.dart';
import '../dtos/02_M_leave_request_form_dto.dart';

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
