// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/close_icon_view_model.dart';
import '../dtos/close_icon_dto.dart';

class CloseIconMapper {
  static CloseIconViewModel fromDto(CloseIconDto dto) {
    return CloseIconViewModel(
      title: dto.raw['title']?.toString() ?? 'closeIcon',
      metadata: dto.raw,
    );
  }
}
