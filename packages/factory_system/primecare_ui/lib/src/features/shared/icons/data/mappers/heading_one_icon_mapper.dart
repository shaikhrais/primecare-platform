// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/heading_one_icon_view_model.dart';
import '../dtos/heading_one_icon_dto.dart';

class HeadingOneIconMapper {
  static HeadingOneIconViewModel fromDto(HeadingOneIconDto dto) {
    return HeadingOneIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingOneIcon',
      metadata: dto.raw,
    );
  }
}
