// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_nav_badge_view_model.dart';
import '../dtos/02_M_fuse_nav_badge_dto.dart';

class FuseNavBadgeMapper {
  static FuseNavBadgeViewModel fromDto(FuseNavBadgeDto dto) {
    return FuseNavBadgeViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavBadge',
      metadata: dto.raw,
    );
  }
}

