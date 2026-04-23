// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_full_screen_toggle_view_model.dart';
import '../dtos/02_M_full_screen_toggle_dto.dart';

class FullScreenToggleMapper {
  static FullScreenToggleViewModel fromDto(FullScreenToggleDto dto) {
    return FullScreenToggleViewModel(
      title: dto.raw['title']?.toString() ?? 'fullScreenToggle',
      metadata: dto.raw,
    );
  }
}

