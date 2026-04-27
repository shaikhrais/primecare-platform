// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_nav_horizontal_group_view_model.dart';
import '../dtos/fuse_nav_horizontal_group_dto.dart';

class FuseNavHorizontalGroupMapper {
  static FuseNavHorizontalGroupViewModel fromDto(
    FuseNavHorizontalGroupDto dto,
  ) {
    return FuseNavHorizontalGroupViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavHorizontalGroup',
      metadata: dto.raw,
    );
  }
}
