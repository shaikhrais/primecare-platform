// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navbar_toggle_button_view_model.dart';
import '../dtos/02_M_navbar_toggle_button_dto.dart';

class NavbarToggleButtonMapper {
  static NavbarToggleButtonViewModel fromDto(NavbarToggleButtonDto dto) {
    return NavbarToggleButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarToggleButton',
      metadata: dto.raw,
    );
  }
}
