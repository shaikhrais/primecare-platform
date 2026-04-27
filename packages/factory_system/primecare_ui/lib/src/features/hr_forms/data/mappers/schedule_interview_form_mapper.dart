// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/schedule_interview_form_view_model.dart';
import '../dtos/schedule_interview_form_dto.dart';

class ScheduleInterviewFormMapper {
  static ScheduleInterviewFormViewModel toViewModel(
    ScheduleInterviewFormDto dto,
  ) {
    return ScheduleInterviewFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static ScheduleInterviewFormDto toDto(
    ScheduleInterviewFormViewModel viewModel,
  ) {
    return ScheduleInterviewFormDto(rawData: viewModel.data);
  }
}
