// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_toggle_button_view_model.dart';
import '../dtos/navbar_toggle_button_dto.dart';

class NavbarToggleButtonMapper {
  static NavbarToggleButtonViewModel fromDto(NavbarToggleButtonDto dto) {
    return NavbarToggleButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarToggleButton',
      metadata: dto.raw,
    );
  }
}
