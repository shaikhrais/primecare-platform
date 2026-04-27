// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_nav_vertical_item_base_view_model.dart';
import '../dtos/fuse_nav_vertical_item_base_dto.dart';

class FuseNavVerticalItemBaseMapper {
  static FuseNavVerticalItemBaseViewModel fromDto(
    FuseNavVerticalItemBaseDto dto,
  ) {
    return FuseNavVerticalItemBaseViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalItemBase',
      metadata: dto.raw,
    );
  }
}
