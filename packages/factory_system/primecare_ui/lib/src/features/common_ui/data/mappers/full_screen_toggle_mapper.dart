// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/full_screen_toggle_view_model.dart';
import '../dtos/full_screen_toggle_dto.dart';

class FullScreenToggleMapper {
  static FullScreenToggleViewModel fromDto(FullScreenToggleDto dto) {
    return FullScreenToggleViewModel(
      title: dto.raw['title']?.toString() ?? 'fullScreenToggle',
      metadata: dto.raw,
    );
  }
}
