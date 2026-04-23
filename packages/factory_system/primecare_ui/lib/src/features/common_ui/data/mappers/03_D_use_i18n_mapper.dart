// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_i18n_view_model.dart';
import '../dtos/02_M_use_i18n_dto.dart';

class UseI18nMapper {
  static UseI18nViewModel fromDto(UseI18nDto dto) {
    return UseI18nViewModel(
      title: dto.raw['title']?.toString() ?? 'useI18n',
      metadata: dto.raw,
    );
  }
}

