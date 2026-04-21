// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_login_screen_view_model.dart';
import '../dtos/02_M_login_screen_dto.dart';

class LoginScreenMapper {
  static LoginScreenViewModel fromDto(LoginScreenDto dto) {
    return LoginScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'loginScreen',
      metadata: dto.raw,
    );
  }
}

