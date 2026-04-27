// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/text_align_button_view_model.dart';
import '../dtos/text_align_button_dto.dart';

class TextAlignButtonMapper {
  static TextAlignButtonViewModel fromDto(TextAlignButtonDto dto) {
    return TextAlignButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'textAlignButton',
      metadata: dto.raw,
    );
  }
}
