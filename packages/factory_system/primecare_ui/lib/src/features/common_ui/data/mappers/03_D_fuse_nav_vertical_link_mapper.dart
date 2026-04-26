// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_vertical_link_view_model.dart';
import '../dtos/02_M_fuse_nav_vertical_link_dto.dart';

class FuseNavVerticalLinkMapper {
  static FuseNavVerticalLinkViewModel fromDto(FuseNavVerticalLinkDto dto) {
    return FuseNavVerticalLinkViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalLink',
      metadata: dto.raw,
    );
  }
}
