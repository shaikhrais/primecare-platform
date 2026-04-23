// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_schedule_open_house_form_view_model.dart';
import '../dtos/02_M_schedule_open_house_form_dto.dart';

class ScheduleOpenHouseFormMapper {
  static ScheduleOpenHouseFormViewModel fromDto(ScheduleOpenHouseFormDto dto) {
    return ScheduleOpenHouseFormViewModel(
      title: dto.raw['title']?.toString() ?? 'scheduleOpenHouseForm',
      metadata: dto.raw,
    );
  }
}

