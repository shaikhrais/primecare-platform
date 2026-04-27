// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/chevron_down_icon_view_model.dart';
import '../dtos/chevron_down_icon_dto.dart';

class ChevronDownIconMapper {
  static ChevronDownIconViewModel fromDto(ChevronDownIconDto dto) {
    return ChevronDownIconViewModel(
      title: dto.raw['title']?.toString() ?? 'chevronDownIcon',
      metadata: dto.raw,
    );
  }
}
