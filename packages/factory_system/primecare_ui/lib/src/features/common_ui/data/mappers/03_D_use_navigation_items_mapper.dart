// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_navigation_items_view_model.dart';
import '../dtos/02_M_use_navigation_items_dto.dart';

class UseNavigationItemsMapper {
  static UseNavigationItemsViewModel fromDto(UseNavigationItemsDto dto) {
    return UseNavigationItemsViewModel(
      title: dto.raw['title']?.toString() ?? 'useNavigationItems',
      metadata: dto.raw,
    );
  }
}
