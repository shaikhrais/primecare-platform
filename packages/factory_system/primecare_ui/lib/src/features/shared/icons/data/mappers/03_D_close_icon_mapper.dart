// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_close_icon_view_model.dart';
import '../dtos/02_M_close_icon_dto.dart';

class CloseIconMapper {
  static CloseIconViewModel fromDto(CloseIconDto dto) {
    return CloseIconViewModel(
      title: dto.raw['title']?.toString() ?? 'closeIcon',
      metadata: dto.raw,
    );
  }
}
