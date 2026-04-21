// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_i18n_context_view_model.dart';
import '../dtos/02_M_i18n_context_dto.dart';

class I18nContextMapper {
  static I18nContextViewModel fromDto(I18nContextDto dto) {
    return I18nContextViewModel(
      title: dto.raw['title']?.toString() ?? 'i18nContext',
      metadata: dto.raw,
    );
  }
}

