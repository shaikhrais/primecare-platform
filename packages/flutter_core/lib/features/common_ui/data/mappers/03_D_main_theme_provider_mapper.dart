// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_main_theme_provider_view_model.dart';
import '../dtos/02_M_main_theme_provider_dto.dart';

class MainThemeProviderMapper {
  static MainThemeProviderViewModel fromDto(MainThemeProviderDto dto) {
    return MainThemeProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'mainThemeProvider',
      metadata: dto.raw,
    );
  }
}

