// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/mark_button_view_model.dart';
import '../dtos/mark_button_dto.dart';

class MarkButtonMapper {
  static MarkButtonViewModel fromDto(MarkButtonDto dto) {
    return MarkButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'markButton',
      metadata: dto.raw,
    );
  }
}
