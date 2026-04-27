// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_style1_view_model.dart';
import '../dtos/navbar_style1_dto.dart';

class NavbarStyle1Mapper {
  static NavbarStyle1ViewModel fromDto(NavbarStyle1Dto dto) {
    return NavbarStyle1ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarStyle1',
      metadata: dto.raw,
    );
  }
}
