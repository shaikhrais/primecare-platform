// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/palette_selector_view_model.dart';
import '../dtos/palette_selector_dto.dart';

class PaletteSelectorMapper {
  static PaletteSelectorViewModel fromDto(PaletteSelectorDto dto) {
    return PaletteSelectorViewModel(
      title: dto.raw['title']?.toString() ?? 'paletteSelector',
      metadata: dto.raw,
    );
  }
}
