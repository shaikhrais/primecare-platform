// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_item_view_model.dart';
import '../dtos/02_M_fuse_nav_item_dto.dart';

class FuseNavItemMapper {
  static FuseNavItemViewModel fromDto(FuseNavItemDto dto) {
    return FuseNavItemViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavItem',
      metadata: dto.raw,
    );
  }
}
