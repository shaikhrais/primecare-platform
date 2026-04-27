// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/theme_toggle_view_model.dart';
import '../dtos/theme_toggle_dto.dart';

class ThemeToggleMapper {
  static ThemeToggleViewModel fromDto(ThemeToggleDto dto) {
    return ThemeToggleViewModel(
      title: dto.raw['title']?.toString() ?? 'themeToggle',
      metadata: dto.raw,
    );
  }
}
