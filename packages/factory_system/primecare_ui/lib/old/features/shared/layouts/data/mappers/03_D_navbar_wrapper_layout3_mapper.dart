// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_wrapper_layout3_view_model.dart';
import '../dtos/02_M_navbar_wrapper_layout3_dto.dart';

class NavbarWrapperLayout3Mapper {
  static NavbarWrapperLayout3ViewModel fromDto(NavbarWrapperLayout3Dto dto) {
    return NavbarWrapperLayout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarWrapperLayout3',
      metadata: dto.raw,
    );
  }
}
