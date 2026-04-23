// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_heading_one_icon_view_model.dart';
import '../dtos/02_M_heading_one_icon_dto.dart';

class HeadingOneIconMapper {
  static HeadingOneIconViewModel fromDto(HeadingOneIconDto dto) {
    return HeadingOneIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingOneIcon',
      metadata: dto.raw,
    );
  }
}

