// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_log_franchisee_vetting_call_form_view_model.dart';
import '../dtos/02_M_log_franchisee_vetting_call_form_dto.dart';

class LogFranchiseeVettingCallFormMapper {
  static LogFranchiseeVettingCallFormViewModel toViewModel(
    LogFranchiseeVettingCallFormDto dto,
  ) {
    return LogFranchiseeVettingCallFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static LogFranchiseeVettingCallFormDto toDto(
    LogFranchiseeVettingCallFormViewModel viewModel,
  ) {
    return LogFranchiseeVettingCallFormDto(rawData: viewModel.data);
  }
}
