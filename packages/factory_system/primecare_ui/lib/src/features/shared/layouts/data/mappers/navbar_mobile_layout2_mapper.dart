// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_mobile_layout2_view_model.dart';
import '../dtos/navbar_mobile_layout2_dto.dart';

class NavbarMobileLayout2Mapper {
  static NavbarMobileLayout2ViewModel fromDto(NavbarMobileLayout2Dto dto) {
    return NavbarMobileLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarMobileLayout2',
      metadata: dto.raw,
    );
  }
}
