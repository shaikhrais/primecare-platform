// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_heading_four_icon_view_model.dart';
import '../dtos/02_M_heading_four_icon_dto.dart';

class HeadingFourIconMapper {
  static HeadingFourIconViewModel fromDto(HeadingFourIconDto dto) {
    return HeadingFourIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingFourIcon',
      metadata: dto.raw,
    );
  }
}

