// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/user_menu_view_model.dart';
import '../dtos/user_menu_dto.dart';

class UserMenuMapper {
  static UserMenuViewModel fromDto(UserMenuDto dto) {
    return UserMenuViewModel(
      title: dto.raw['title']?.toString() ?? 'userMenu',
      metadata: dto.raw,
    );
  }
}
