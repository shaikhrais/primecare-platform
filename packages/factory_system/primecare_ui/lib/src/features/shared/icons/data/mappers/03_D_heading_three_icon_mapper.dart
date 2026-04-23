// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_heading_three_icon_view_model.dart';
import '../dtos/02_M_heading_three_icon_dto.dart';

class HeadingThreeIconMapper {
  static HeadingThreeIconViewModel fromDto(HeadingThreeIconDto dto) {
    return HeadingThreeIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingThreeIcon',
      metadata: dto.raw,
    );
  }
}

