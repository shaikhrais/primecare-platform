// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/heading_four_icon_view_model.dart';
import '../dtos/heading_four_icon_dto.dart';

class HeadingFourIconMapper {
  static HeadingFourIconViewModel fromDto(HeadingFourIconDto dto) {
    return HeadingFourIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingFourIcon',
      metadata: dto.raw,
    );
  }
}
