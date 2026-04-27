// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/light_dark_mode_toggle_view_model.dart';
import '../dtos/light_dark_mode_toggle_dto.dart';

class LightDarkModeToggleMapper {
  static LightDarkModeToggleViewModel fromDto(LightDarkModeToggleDto dto) {
    return LightDarkModeToggleViewModel(
      title: dto.raw['title']?.toString() ?? 'lightDarkModeToggle',
      metadata: dto.raw,
    );
  }
}
