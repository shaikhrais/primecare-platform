// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navigation_view_model.dart';
import '../dtos/02_M_navigation_dto.dart';

class NavigationMapper {
  static NavigationViewModel fromDto(NavigationDto dto) {
    return NavigationViewModel(
      title: dto.raw['title']?.toString() ?? 'navigation',
      metadata: dto.raw,
    );
  }
}

