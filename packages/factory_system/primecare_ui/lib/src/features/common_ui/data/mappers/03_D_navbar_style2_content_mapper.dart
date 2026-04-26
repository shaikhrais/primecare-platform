// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_style2_content_view_model.dart';
import '../dtos/02_M_navbar_style2_content_dto.dart';

class NavbarStyle2ContentMapper {
  static NavbarStyle2ContentViewModel fromDto(NavbarStyle2ContentDto dto) {
    return NavbarStyle2ContentViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarStyle2Content',
      metadata: dto.raw,
    );
  }
}
