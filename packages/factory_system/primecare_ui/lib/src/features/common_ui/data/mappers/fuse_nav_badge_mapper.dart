// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_nav_badge_view_model.dart';
import '../dtos/fuse_nav_badge_dto.dart';

class FuseNavBadgeMapper {
  static FuseNavBadgeViewModel fromDto(FuseNavBadgeDto dto) {
    return FuseNavBadgeViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavBadge',
      metadata: dto.raw,
    );
  }
}
