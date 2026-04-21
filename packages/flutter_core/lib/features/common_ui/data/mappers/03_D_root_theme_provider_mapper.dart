// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_root_theme_provider_view_model.dart';
import '../dtos/02_M_root_theme_provider_dto.dart';

class RootThemeProviderMapper {
  static RootThemeProviderViewModel fromDto(RootThemeProviderDto dto) {
    return RootThemeProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'rootThemeProvider',
      metadata: dto.raw,
    );
  }
}

