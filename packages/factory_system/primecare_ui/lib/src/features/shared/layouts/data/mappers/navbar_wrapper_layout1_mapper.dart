// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/navbar_wrapper_layout1_view_model.dart';
import '../dtos/navbar_wrapper_layout1_dto.dart';

class NavbarWrapperLayout1Mapper {
  static NavbarWrapperLayout1ViewModel fromDto(NavbarWrapperLayout1Dto dto) {
    return NavbarWrapperLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarWrapperLayout1',
      metadata: dto.raw,
    );
  }
}
