// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/heading_icon_view_model.dart';
import '../dtos/heading_icon_dto.dart';

class HeadingIconMapper {
  static HeadingIconViewModel fromDto(HeadingIconDto dto) {
    return HeadingIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingIcon',
      metadata: dto.raw,
    );
  }
}
