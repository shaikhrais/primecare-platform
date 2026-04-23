// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_wrapper_layout2_view_model.dart';
import '../dtos/02_M_navbar_wrapper_layout2_dto.dart';

class NavbarWrapperLayout2Mapper {
  static NavbarWrapperLayout2ViewModel fromDto(NavbarWrapperLayout2Dto dto) {
    return NavbarWrapperLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarWrapperLayout2',
      metadata: dto.raw,
    );
  }
}

