// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_heading_five_icon_view_model.dart';
import '../dtos/02_M_heading_five_icon_dto.dart';

class HeadingFiveIconMapper {
  static HeadingFiveIconViewModel fromDto(HeadingFiveIconDto dto) {
    return HeadingFiveIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingFiveIcon',
      metadata: dto.raw,
    );
  }
}

