// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/navigation_search_view_model.dart';
import '../dtos/navigation_search_dto.dart';

class NavigationSearchMapper {
  static NavigationSearchViewModel fromDto(NavigationSearchDto dto) {
    return NavigationSearchViewModel(
      title: dto.raw['title']?.toString() ?? 'navigationSearch',
      metadata: dto.raw,
    );
  }
}
