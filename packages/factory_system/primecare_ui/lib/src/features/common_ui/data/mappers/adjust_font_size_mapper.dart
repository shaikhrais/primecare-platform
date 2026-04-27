// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/adjust_font_size_view_model.dart';
import '../dtos/adjust_font_size_dto.dart';

class AdjustFontSizeMapper {
  static AdjustFontSizeViewModel fromDto(AdjustFontSizeDto dto) {
    return AdjustFontSizeViewModel(
      title: dto.raw['title']?.toString() ?? 'adjustFontSize',
      metadata: dto.raw,
    );
  }
}
