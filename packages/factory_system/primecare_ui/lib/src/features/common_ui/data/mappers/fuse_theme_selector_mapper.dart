// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_theme_selector_view_model.dart';
import '../dtos/fuse_theme_selector_dto.dart';

class FuseThemeSelectorMapper {
  static FuseThemeSelectorViewModel fromDto(FuseThemeSelectorDto dto) {
    return FuseThemeSelectorViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseThemeSelector',
      metadata: dto.raw,
    );
  }
}
