// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_horizontal_item_view_model.dart';
import '../dtos/02_M_fuse_nav_horizontal_item_dto.dart';

class FuseNavHorizontalItemMapper {
  static FuseNavHorizontalItemViewModel fromDto(FuseNavHorizontalItemDto dto) {
    return FuseNavHorizontalItemViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavHorizontalItem',
      metadata: dto.raw,
    );
  }
}

