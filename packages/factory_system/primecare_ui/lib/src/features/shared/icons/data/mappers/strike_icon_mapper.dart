// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/strike_icon_view_model.dart';
import '../dtos/strike_icon_dto.dart';

class StrikeIconMapper {
  static StrikeIconViewModel fromDto(StrikeIconDto dto) {
    return StrikeIconViewModel(
      title: dto.raw['title']?.toString() ?? 'strikeIcon',
      metadata: dto.raw,
    );
  }
}
