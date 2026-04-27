// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/underline_icon_view_model.dart';
import '../dtos/underline_icon_dto.dart';

class UnderlineIconMapper {
  static UnderlineIconViewModel fromDto(UnderlineIconDto dto) {
    return UnderlineIconViewModel(
      title: dto.raw['title']?.toString() ?? 'underlineIcon',
      metadata: dto.raw,
    );
  }
}
