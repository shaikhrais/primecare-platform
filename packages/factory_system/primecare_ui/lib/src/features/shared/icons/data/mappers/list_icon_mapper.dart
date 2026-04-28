// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/list_icon_view_model.dart';
import '../dtos/list_icon_dto.dart';

class ListIconMapper {
  static ListIconViewModel fromDto(ListIconDto dto) {
    return ListIconViewModel(
      title: dto.raw['title']?.toString() ?? 'listIcon',
      metadata: dto.raw,
    );
  }
}
