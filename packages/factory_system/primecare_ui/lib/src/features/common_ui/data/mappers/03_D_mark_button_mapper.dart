// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_mark_button_view_model.dart';
import '../dtos/02_M_mark_button_dto.dart';

class MarkButtonMapper {
  static MarkButtonViewModel fromDto(MarkButtonDto dto) {
    return MarkButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'markButton',
      metadata: dto.raw,
    );
  }
}
