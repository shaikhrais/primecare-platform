// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/sun_icon_view_model.dart';
import '../dtos/sun_icon_dto.dart';

class SunIconMapper {
  static SunIconViewModel fromDto(SunIconDto dto) {
    return SunIconViewModel(
      title: dto.raw['title']?.toString() ?? 'sunIcon',
      metadata: dto.raw,
    );
  }
}
