// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/language_switcher_view_model.dart';
import '../dtos/language_switcher_dto.dart';

class LanguageSwitcherMapper {
  static LanguageSwitcherViewModel fromDto(LanguageSwitcherDto dto) {
    return LanguageSwitcherViewModel(
      title: dto.raw['title']?.toString() ?? 'languageSwitcher',
      metadata: dto.raw,
    );
  }
}
