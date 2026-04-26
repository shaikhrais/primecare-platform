// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_bold_icon_view_model.dart';
import '../dtos/02_M_bold_icon_dto.dart';

class BoldIconMapper {
  static BoldIconViewModel fromDto(BoldIconDto dto) {
    return BoldIconViewModel(
      title: dto.raw['title']?.toString() ?? 'boldIcon',
      metadata: dto.raw,
    );
  }
}
