// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_heading_dropdown_menu_view_model.dart';
import '../dtos/02_M_heading_dropdown_menu_dto.dart';

class HeadingDropdownMenuMapper {
  static HeadingDropdownMenuViewModel fromDto(HeadingDropdownMenuDto dto) {
    return HeadingDropdownMenuViewModel(
      title: dto.raw['title']?.toString() ?? 'headingDropdownMenu',
      metadata: dto.raw,
    );
  }
}
