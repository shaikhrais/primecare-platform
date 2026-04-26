// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_vertical_collapse_view_model.dart';
import '../dtos/02_M_fuse_nav_vertical_collapse_dto.dart';

class FuseNavVerticalCollapseMapper {
  static FuseNavVerticalCollapseViewModel fromDto(
    FuseNavVerticalCollapseDto dto,
  ) {
    return FuseNavVerticalCollapseViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalCollapse',
      metadata: dto.raw,
    );
  }
}
