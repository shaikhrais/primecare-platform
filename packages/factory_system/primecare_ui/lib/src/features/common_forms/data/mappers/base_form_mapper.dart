// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/base_form_view_model.dart';
import '../dtos/base_form_dto.dart';

class BaseFormMapper {
  static BaseFormViewModel fromDto(BaseFormDto dto) {
    return BaseFormViewModel(
      title: dto.raw['title']?.toString() ?? 'baseForm',
      metadata: dto.raw,
    );
  }
}
