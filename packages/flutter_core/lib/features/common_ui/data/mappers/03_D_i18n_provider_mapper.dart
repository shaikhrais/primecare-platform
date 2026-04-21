// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_i18n_provider_view_model.dart';
import '../dtos/02_M_i18n_provider_dto.dart';

class I18nProviderMapper {
  static I18nProviderViewModel fromDto(I18nProviderDto dto) {
    return I18nProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'i18nProvider',
      metadata: dto.raw,
    );
  }
}

