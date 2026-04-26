// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_navigation_search_view_model.dart';
import '../dtos/02_M_navigation_search_dto.dart';

class NavigationSearchMapper {
  static NavigationSearchViewModel fromDto(NavigationSearchDto dto) {
    return NavigationSearchViewModel(
      title: dto.raw['title']?.toString() ?? 'navigationSearch',
      metadata: dto.raw,
    );
  }
}
