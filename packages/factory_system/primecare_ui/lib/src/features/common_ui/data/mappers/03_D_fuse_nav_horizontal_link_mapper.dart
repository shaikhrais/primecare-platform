// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_horizontal_link_view_model.dart';
import '../dtos/02_M_fuse_nav_horizontal_link_dto.dart';

class FuseNavHorizontalLinkMapper {
  static FuseNavHorizontalLinkViewModel fromDto(FuseNavHorizontalLinkDto dto) {
    return FuseNavHorizontalLinkViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavHorizontalLink',
      metadata: dto.raw,
    );
  }
}
