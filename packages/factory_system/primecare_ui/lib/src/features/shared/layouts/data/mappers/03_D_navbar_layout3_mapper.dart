// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_layout3_view_model.dart';
import '../dtos/02_M_navbar_layout3_dto.dart';

class NavbarLayout3Mapper {
  static NavbarLayout3ViewModel fromDto(NavbarLayout3Dto dto) {
    return NavbarLayout3ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarLayout3',
      metadata: dto.raw,
    );
  }
}
