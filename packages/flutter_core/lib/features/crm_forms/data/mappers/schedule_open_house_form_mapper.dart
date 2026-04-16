import '../../domain/models/schedule_open_house_form_view_model.dart';
import '../dtos/schedule_open_house_form_dto.dart';

class ScheduleOpenHouseFormMapper {
  static ScheduleOpenHouseFormViewModel toViewModel(
    ScheduleOpenHouseFormDto dto,
  ) {
    return ScheduleOpenHouseFormViewModel(
      isLoading: false,
      isSuccess: true,
      data: dto.rawData,
    );
  }

  static ScheduleOpenHouseFormDto toDto(
    ScheduleOpenHouseFormViewModel viewModel,
  ) {
    return ScheduleOpenHouseFormDto(rawData: viewModel.data);
  }
}
