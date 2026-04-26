// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_theme_view_model.dart';
import '../dtos/02_M_navbar_theme_dto.dart';

class NavbarThemeMapper {
  static NavbarThemeViewModel fromDto(NavbarThemeDto dto) {
    return NavbarThemeViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarTheme',
      metadata: dto.raw,
    );
  }
}
