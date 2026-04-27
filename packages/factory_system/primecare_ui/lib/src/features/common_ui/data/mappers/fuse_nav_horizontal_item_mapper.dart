// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_nav_horizontal_item_view_model.dart';
import '../dtos/fuse_nav_horizontal_item_dto.dart';

class FuseNavHorizontalItemMapper {
  static FuseNavHorizontalItemViewModel fromDto(FuseNavHorizontalItemDto dto) {
    return FuseNavHorizontalItemViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavHorizontalItem',
      metadata: dto.raw,
    );
  }
}
