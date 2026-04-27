// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/align_right_icon_view_model.dart';
import '../dtos/align_right_icon_dto.dart';

class AlignRightIconMapper {
  static AlignRightIconViewModel fromDto(AlignRightIconDto dto) {
    return AlignRightIconViewModel(
      title: dto.raw['title']?.toString() ?? 'alignRightIcon',
      metadata: dto.raw,
    );
  }
}
