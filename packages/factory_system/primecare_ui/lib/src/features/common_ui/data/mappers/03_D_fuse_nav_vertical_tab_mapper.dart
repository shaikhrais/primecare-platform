// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_vertical_tab_view_model.dart';
import '../dtos/02_M_fuse_nav_vertical_tab_dto.dart';

class FuseNavVerticalTabMapper {
  static FuseNavVerticalTabViewModel fromDto(FuseNavVerticalTabDto dto) {
    return FuseNavVerticalTabViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavVerticalTab',
      metadata: dto.raw,
    );
  }
}
