// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/jwt_sign_in_tab_view_model.dart';
import '../dtos/jwt_sign_in_tab_dto.dart';

class JwtSignInTabMapper {
  static JwtSignInTabViewModel fromDto(JwtSignInTabDto dto) {
    return JwtSignInTabViewModel(
      title: dto.raw['title']?.toString() ?? 'jwtSignInTab',
      metadata: dto.raw,
    );
  }
}
