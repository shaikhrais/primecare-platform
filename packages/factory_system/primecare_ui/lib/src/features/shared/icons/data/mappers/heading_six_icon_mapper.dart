// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/heading_six_icon_view_model.dart';
import '../dtos/heading_six_icon_dto.dart';

class HeadingSixIconMapper {
  static HeadingSixIconViewModel fromDto(HeadingSixIconDto dto) {
    return HeadingSixIconViewModel(
      title: dto.raw['title']?.toString() ?? 'headingSixIcon',
      metadata: dto.raw,
    );
  }
}
