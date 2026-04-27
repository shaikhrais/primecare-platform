// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_theme_hooks_view_model.dart';
import '../dtos/fuse_theme_hooks_dto.dart';

class FuseThemeHooksMapper {
  static FuseThemeHooksViewModel fromDto(FuseThemeHooksDto dto) {
    return FuseThemeHooksViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseThemeHooks',
      metadata: dto.raw,
    );
  }
}
