// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_style2_view_model.dart';
import '../dtos/navbar_style2_dto.dart';

class NavbarStyle2Mapper {
  static NavbarStyle2ViewModel fromDto(NavbarStyle2Dto dto) {
    return NavbarStyle2ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarStyle2',
      metadata: dto.raw,
    );
  }
}
