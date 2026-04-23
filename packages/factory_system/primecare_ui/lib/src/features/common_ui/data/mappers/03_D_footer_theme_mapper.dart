// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_footer_theme_view_model.dart';
import '../dtos/02_M_footer_theme_dto.dart';

class FooterThemeMapper {
  static FooterThemeViewModel fromDto(FooterThemeDto dto) {
    return FooterThemeViewModel(
      title: dto.raw['title']?.toString() ?? 'footerTheme',
      metadata: dto.raw,
    );
  }
}

