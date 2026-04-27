// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/list_dropdown_menu_view_model.dart';
import '../dtos/list_dropdown_menu_dto.dart';

class ListDropdownMenuMapper {
  static ListDropdownMenuViewModel fromDto(ListDropdownMenuDto dto) {
    return ListDropdownMenuViewModel(
      title: dto.raw['title']?.toString() ?? 'listDropdownMenu',
      metadata: dto.raw,
    );
  }
}
