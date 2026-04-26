// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_toggle_fab_layout1_view_model.dart';
import '../dtos/02_M_navbar_toggle_fab_layout1_dto.dart';

class NavbarToggleFabLayout1Mapper {
  static NavbarToggleFabLayout1ViewModel fromDto(
    NavbarToggleFabLayout1Dto dto,
  ) {
    return NavbarToggleFabLayout1ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarToggleFabLayout1',
      metadata: dto.raw,
    );
  }
}
