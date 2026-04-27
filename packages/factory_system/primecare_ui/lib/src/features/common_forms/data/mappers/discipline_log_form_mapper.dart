// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/discipline_log_form_view_model.dart';
import '../dtos/discipline_log_form_dto.dart';

class DisciplineLogFormMapper {
  static DisciplineLogFormViewModel fromDto(DisciplineLogFormDto dto) {
    return DisciplineLogFormViewModel(
      title: dto.raw['title']?.toString() ?? 'disciplineLogForm',
      metadata: dto.raw,
    );
  }
}
