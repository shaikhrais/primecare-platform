// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_heading_icon_view_model.dart';
import '../dtos/02_M_heading_icon_dto.dart';

class HeadingIconMapper {
  static HeadingIconViewModel fromDto(HeadingIconDto dto) {
    return HeadingIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingIcon',
      metadata: dto.raw,
    );
  }
}

