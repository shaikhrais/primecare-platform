// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/navbar_toggle_fab_layout2_view_model.dart';
import '../dtos/navbar_toggle_fab_layout2_dto.dart';

class NavbarToggleFabLayout2Mapper {
  static NavbarToggleFabLayout2ViewModel fromDto(
    NavbarToggleFabLayout2Dto dto,
  ) {
    return NavbarToggleFabLayout2ViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarToggleFabLayout2',
      metadata: dto.raw,
    );
  }
}
