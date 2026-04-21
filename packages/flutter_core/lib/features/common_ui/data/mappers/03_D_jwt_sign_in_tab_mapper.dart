// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_jwt_sign_in_tab_view_model.dart';
import '../dtos/02_M_jwt_sign_in_tab_dto.dart';

class JwtSignInTabMapper {
  static JwtSignInTabViewModel fromDto(JwtSignInTabDto dto) {
    return JwtSignInTabViewModel(
      title: dto.raw['title']?.toString() ?? 'jwtSignInTab',
      metadata: dto.raw,
    );
  }
}

