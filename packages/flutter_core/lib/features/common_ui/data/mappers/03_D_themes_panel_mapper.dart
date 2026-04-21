// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_themes_panel_view_model.dart';
import '../dtos/02_M_themes_panel_dto.dart';

class ThemesPanelMapper {
  static ThemesPanelViewModel fromDto(ThemesPanelDto dto) {
    return ThemesPanelViewModel(
      title: dto.raw['title']?.toString() ?? 'themesPanel',
      metadata: dto.raw,
    );
  }
}

