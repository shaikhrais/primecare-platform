// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_mobile_layout3_view_model.dart';
import '../dtos/02_M_navbar_mobile_layout3_dto.dart';

class NavbarMobileLayout3Mapper {
  static NavbarMobileLayout3ViewModel fromDto(NavbarMobileLayout3Dto dto) {
    return NavbarMobileLayout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarMobileLayout3',
      metadata: dto.raw,
    );
  }
}
