// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_strike_icon_view_model.dart';
import '../dtos/02_M_strike_icon_dto.dart';

class StrikeIconMapper {
  static StrikeIconViewModel fromDto(StrikeIconDto dto) {
    return StrikeIconViewModel(
      title: dto.raw['title']?.toString() ?? 'strikeIcon',
      metadata: dto.raw,
    );
  }
}

