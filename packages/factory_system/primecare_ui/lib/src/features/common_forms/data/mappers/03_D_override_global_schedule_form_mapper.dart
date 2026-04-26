// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_override_global_schedule_form_view_model.dart';
import '../dtos/02_M_override_global_schedule_form_dto.dart';

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
