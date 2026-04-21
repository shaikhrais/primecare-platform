// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_vertical_group_view_model.dart';
import '../dtos/02_M_fuse_nav_vertical_group_dto.dart';

class FuseNavVerticalGroupMapper {
  static FuseNavVerticalGroupViewModel fromDto(FuseNavVerticalGroupDto dto) {
    return FuseNavVerticalGroupViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalGroup',
      metadata: dto.raw,
    );
  }
}

