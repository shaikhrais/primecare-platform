// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/heading_five_icon_view_model.dart';
import '../dtos/heading_five_icon_dto.dart';

class HeadingFiveIconMapper {
  static HeadingFiveIconViewModel fromDto(HeadingFiveIconDto dto) {
    return HeadingFiveIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingFiveIcon',
      metadata: dto.raw,
    );
  }
}
