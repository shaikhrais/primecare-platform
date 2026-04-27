// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navbar_pin_toggle_button_view_model.dart';
import '../dtos/navbar_pin_toggle_button_dto.dart';

class NavbarPinToggleButtonMapper {
  static NavbarPinToggleButtonViewModel fromDto(NavbarPinToggleButtonDto dto) {
    return NavbarPinToggleButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'navbarPinToggleButton',
      metadata: dto.raw,
    );
  }
}
