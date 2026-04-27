// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_style2_content_view_model.dart';
import '../dtos/navbar_style2_content_dto.dart';

class NavbarStyle2ContentMapper {
  static NavbarStyle2ContentViewModel fromDto(NavbarStyle2ContentDto dto) {
    return NavbarStyle2ContentViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarStyle2Content',
      metadata: dto.raw,
    );
  }
}
