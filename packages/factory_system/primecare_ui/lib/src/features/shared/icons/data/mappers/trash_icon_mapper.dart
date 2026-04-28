// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/trash_icon_view_model.dart';
import '../dtos/trash_icon_dto.dart';

class TrashIconMapper {
  static TrashIconViewModel fromDto(TrashIconDto dto) {
    return TrashIconViewModel(
      title: dto.raw['title']?.toString() ?? 'trashIcon',
      metadata: dto.raw,
    );
  }
}
