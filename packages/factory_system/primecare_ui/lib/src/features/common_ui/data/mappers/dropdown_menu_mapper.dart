// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/dropdown_menu_view_model.dart';
import '../dtos/dropdown_menu_dto.dart';

class DropdownMenuMapper {
  static DropdownMenuViewModel fromDto(DropdownMenuDto dto) {
    return DropdownMenuViewModel(
      title: dto.raw['title']?.toString() ?? 'dropdownMenu',
      metadata: dto.raw,
    );
  }
}
