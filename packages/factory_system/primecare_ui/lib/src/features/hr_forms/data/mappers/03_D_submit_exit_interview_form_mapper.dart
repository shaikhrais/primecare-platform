// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_submit_exit_interview_form_view_model.dart';
import '../dtos/02_M_submit_exit_interview_form_dto.dart';

class SubmitExitInterviewFormMapper {
  static SubmitExitInterviewFormViewModel toViewModel(
    SubmitExitInterviewFormDto dto,
  ) {
    return SubmitExitInterviewFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static SubmitExitInterviewFormDto toDto(
    SubmitExitInterviewFormViewModel viewModel,
  ) {
    return SubmitExitInterviewFormDto(rawData: viewModel.data);
  }
}
