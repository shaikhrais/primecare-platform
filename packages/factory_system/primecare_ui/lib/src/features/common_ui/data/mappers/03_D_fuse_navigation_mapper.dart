// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_navigation_view_model.dart';
import '../dtos/02_M_fuse_navigation_dto.dart';

class FuseNavigationMapper {
  static FuseNavigationViewModel fromDto(FuseNavigationDto dto) {
    return FuseNavigationViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavigation',
      metadata: dto.raw,
    );
  }
}
