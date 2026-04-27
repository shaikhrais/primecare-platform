// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/log_infection_control_form_view_model.dart';
import '../dtos/log_infection_control_form_dto.dart';

class LogInfectionControlFormMapper {
  static LogInfectionControlFormViewModel fromDto(
    LogInfectionControlFormDto dto,
  ) {
    return LogInfectionControlFormViewModel(
      title: dto.raw['title']?.toString() ?? 'logInfectionControlForm',
      metadata: dto.raw,
    );
  }
}
