// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_heading_button_view_model.dart';
import '../dtos/02_M_heading_button_dto.dart';

class HeadingButtonMapper {
  static HeadingButtonViewModel fromDto(HeadingButtonDto dto) {
    return HeadingButtonViewModel(
      title: dto.raw['title']?.toString() ?? 'headingButton',
      metadata: dto.raw,
    );
  }
}

