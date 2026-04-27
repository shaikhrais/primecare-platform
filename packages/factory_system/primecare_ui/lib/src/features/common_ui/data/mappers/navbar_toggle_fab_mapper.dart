// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_toggle_fab_view_model.dart';
import '../dtos/navbar_toggle_fab_dto.dart';

class NavbarToggleFabMapper {
  static NavbarToggleFabViewModel fromDto(NavbarToggleFabDto dto) {
    return NavbarToggleFabViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarToggleFab',
      metadata: dto.raw,
    );
  }
}
