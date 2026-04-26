// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_vertical_item_view_model.dart';
import '../dtos/02_M_fuse_nav_vertical_item_dto.dart';

class FuseNavVerticalItemMapper {
  static FuseNavVerticalItemViewModel fromDto(FuseNavVerticalItemDto dto) {
    return FuseNavVerticalItemViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalItem',
      metadata: dto.raw,
    );
  }
}
