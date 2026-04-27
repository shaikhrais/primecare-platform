// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_theme_view_model.dart';
import '../dtos/fuse_theme_dto.dart';

class FuseThemeMapper {
  static FuseThemeViewModel fromDto(FuseThemeDto dto) {
    return FuseThemeViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseTheme',
      metadata: dto.raw,
    );
  }
}
