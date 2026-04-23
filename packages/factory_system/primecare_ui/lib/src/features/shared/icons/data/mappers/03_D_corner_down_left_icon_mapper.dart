// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_corner_down_left_icon_view_model.dart';
import '../dtos/02_M_corner_down_left_icon_dto.dart';

class CornerDownLeftIconMapper {
  static CornerDownLeftIconViewModel fromDto(CornerDownLeftIconDto dto) {
    return CornerDownLeftIconViewModel(
      title: dto.raw['title']?.toString() ?? 'cornerDownLeftIcon',
      metadata: dto.raw,
    );
  }
}

