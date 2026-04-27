// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/override_global_schedule_form_view_model.dart';
import '../dtos/override_global_schedule_form_dto.dart';

class OverrideGlobalScheduleFormMapper {
  static OverrideGlobalScheduleFormViewModel fromDto(
    OverrideGlobalScheduleFormDto dto,
  ) {
    return OverrideGlobalScheduleFormViewModel(
      title: dto.raw['title']?.toString() ?? 'overrideGlobalScheduleForm',
      metadata: dto.raw,
    );
  }
}
