// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_log_infection_control_form_view_model.dart';
import '../dtos/02_M_log_infection_control_form_dto.dart';

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
