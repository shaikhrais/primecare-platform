// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_theme_preview_view_model.dart';
import '../dtos/02_M_theme_preview_dto.dart';

class ThemePreviewMapper {
  static ThemePreviewViewModel fromDto(ThemePreviewDto dto) {
    return ThemePreviewViewModel(
      title: dto.raw['title']?.toString() ?? 'themePreview',
      metadata: dto.raw,
    );
  }
}

