// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/arrow_left_icon_view_model.dart';
import '../dtos/arrow_left_icon_dto.dart';

class ArrowLeftIconMapper {
  static ArrowLeftIconViewModel fromDto(ArrowLeftIconDto dto) {
    return ArrowLeftIconViewModel(
      title: dto.raw['title']?.toString() ?? 'arrowLeftIcon',
      metadata: dto.raw,
    );
  }
}
