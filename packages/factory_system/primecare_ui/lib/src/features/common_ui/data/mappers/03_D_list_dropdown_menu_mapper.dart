// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_list_dropdown_menu_view_model.dart';
import '../dtos/02_M_list_dropdown_menu_dto.dart';

class ListDropdownMenuMapper {
  static ListDropdownMenuViewModel fromDto(ListDropdownMenuDto dto) {
    return ListDropdownMenuViewModel(
      title: dto.raw['title']?.toString() ?? 'listDropdownMenu',
      metadata: dto.raw,
    );
  }
}

