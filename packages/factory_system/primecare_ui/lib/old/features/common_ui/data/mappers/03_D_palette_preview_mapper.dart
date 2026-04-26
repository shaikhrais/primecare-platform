// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_palette_preview_view_model.dart';
import '../dtos/02_M_palette_preview_dto.dart';

class PalettePreviewMapper {
  static PalettePreviewViewModel fromDto(PalettePreviewDto dto) {
    return PalettePreviewViewModel(
      title: dto.raw['title']?.toString() ?? 'palettePreview',
      metadata: dto.raw,
    );
  }
}
