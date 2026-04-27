// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/align_left_icon_view_model.dart';
import '../dtos/align_left_icon_dto.dart';

class AlignLeftIconMapper {
  static AlignLeftIconViewModel fromDto(AlignLeftIconDto dto) {
    return AlignLeftIconViewModel(
      title: dto.raw['title']?.toString() ?? 'alignLeftIcon',
      metadata: dto.raw,
    );
  }
}
