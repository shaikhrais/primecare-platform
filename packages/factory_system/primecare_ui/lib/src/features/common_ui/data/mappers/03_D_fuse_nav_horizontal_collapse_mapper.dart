// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_horizontal_collapse_view_model.dart';
import '../dtos/02_M_fuse_nav_horizontal_collapse_dto.dart';

class FuseNavHorizontalCollapseMapper {
  static FuseNavHorizontalCollapseViewModel fromDto(
    FuseNavHorizontalCollapseDto dto,
  ) {
    return FuseNavHorizontalCollapseViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavHorizontalCollapse',
      metadata: dto.raw,
    );
  }
}
