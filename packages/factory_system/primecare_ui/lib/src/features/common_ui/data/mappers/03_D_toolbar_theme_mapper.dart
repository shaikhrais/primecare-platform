// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_toolbar_theme_view_model.dart';
import '../dtos/02_M_toolbar_theme_dto.dart';

class ToolbarThemeMapper {
  static ToolbarThemeViewModel fromDto(ToolbarThemeDto dto) {
    return ToolbarThemeViewModel(
      title: dto.raw['title']?.toString() ?? 'toolbarTheme',
      metadata: dto.raw,
    );
  }
}
