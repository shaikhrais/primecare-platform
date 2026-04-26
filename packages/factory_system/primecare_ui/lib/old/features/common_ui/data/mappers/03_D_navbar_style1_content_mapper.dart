// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_style1_content_view_model.dart';
import '../dtos/02_M_navbar_style1_content_dto.dart';

class NavbarStyle1ContentMapper {
  static NavbarStyle1ContentViewModel fromDto(NavbarStyle1ContentDto dto) {
    return NavbarStyle1ContentViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarStyle1Content',
      metadata: dto.raw,
    );
  }
}
