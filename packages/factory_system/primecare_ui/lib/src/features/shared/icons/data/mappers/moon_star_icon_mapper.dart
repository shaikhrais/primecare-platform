// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/moon_star_icon_view_model.dart';
import '../dtos/moon_star_icon_dto.dart';

class MoonStarIconMapper {
  static MoonStarIconViewModel fromDto(MoonStarIconDto dto) {
    return MoonStarIconViewModel(
      title: dto.raw['title']?.toString() ?? 'moonStarIcon',
      metadata: dto.raw,
    );
  }
}
