// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/heading_three_icon_view_model.dart';
import '../dtos/heading_three_icon_dto.dart';

class HeadingThreeIconMapper {
  static HeadingThreeIconViewModel fromDto(HeadingThreeIconDto dto) {
    return HeadingThreeIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingThreeIcon',
      metadata: dto.raw,
    );
  }
}
