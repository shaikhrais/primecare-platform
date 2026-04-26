// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_list_ordered_icon_view_model.dart';
import '../dtos/02_M_list_ordered_icon_dto.dart';

class ListOrderedIconMapper {
  static ListOrderedIconViewModel fromDto(ListOrderedIconDto dto) {
    return ListOrderedIconViewModel(
      title: dto.raw['title']?.toString() ?? 'listOrderedIcon',
      metadata: dto.raw,
    );
  }
}
