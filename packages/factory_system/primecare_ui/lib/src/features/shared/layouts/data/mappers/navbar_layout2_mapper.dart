// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_layout2_view_model.dart';
import '../dtos/navbar_layout2_dto.dart';

class NavbarLayout2Mapper {
  static NavbarLayout2ViewModel fromDto(NavbarLayout2Dto dto) {
    return NavbarLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarLayout2',
      metadata: dto.raw,
    );
  }
}
