// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/palette_preview_view_model.dart';
import '../dtos/palette_preview_dto.dart';

class PalettePreviewMapper {
  static PalettePreviewViewModel fromDto(PalettePreviewDto dto) {
    return PalettePreviewViewModel(
      title: dto.raw['title']?.toString() ?? 'palettePreview',
      metadata: dto.raw,
    );
  }
}
