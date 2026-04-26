// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_light_dark_mode_toggle_view_model.dart';
import '../dtos/02_M_light_dark_mode_toggle_dto.dart';

class LightDarkModeToggleMapper {
  static LightDarkModeToggleViewModel fromDto(LightDarkModeToggleDto dto) {
    return LightDarkModeToggleViewModel(
      title: dto.raw['title']?.toString() ?? 'lightDarkModeToggle',
      metadata: dto.raw,
    );
  }
}
