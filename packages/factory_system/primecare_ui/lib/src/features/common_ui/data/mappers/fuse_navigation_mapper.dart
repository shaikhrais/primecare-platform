// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_navigation_view_model.dart';
import '../dtos/fuse_navigation_dto.dart';

class FuseNavigationMapper {
  static FuseNavigationViewModel fromDto(FuseNavigationDto dto) {
    return FuseNavigationViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseNavigation',
      metadata: dto.raw,
    );
  }
}
