// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_palette_selector_view_model.dart';
import '../dtos/02_M_palette_selector_dto.dart';

class PaletteSelectorMapper {
  static PaletteSelectorViewModel fromDto(PaletteSelectorDto dto) {
    return PaletteSelectorViewModel(
      title: dto.raw['title']?.toString() ?? 'paletteSelector',
      metadata: dto.raw,
    );
  }
}

