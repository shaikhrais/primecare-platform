// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_theme_toggle_view_model.dart';
import '../dtos/02_M_theme_toggle_dto.dart';

class ThemeToggleMapper {
  static ThemeToggleViewModel fromDto(ThemeToggleDto dto) {
    return ThemeToggleViewModel(
      title: dto.raw['title']?.toString() ?? 'themeToggle',
      metadata: dto.raw,
    );
  }
}

