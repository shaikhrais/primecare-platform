// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/heading_two_icon_view_model.dart';
import '../dtos/heading_two_icon_dto.dart';

class HeadingTwoIconMapper {
  static HeadingTwoIconViewModel fromDto(HeadingTwoIconDto dto) {
    return HeadingTwoIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingTwoIcon',
      metadata: dto.raw,
    );
  }
}
