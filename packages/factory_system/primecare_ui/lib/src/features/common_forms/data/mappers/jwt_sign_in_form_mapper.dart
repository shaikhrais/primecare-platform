// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/jwt_sign_in_form_view_model.dart';
import '../dtos/jwt_sign_in_form_dto.dart';

class JwtSignInFormMapper {
  static JwtSignInFormViewModel fromDto(JwtSignInFormDto dto) {
    return JwtSignInFormViewModel(
      title: dto.raw['title']?.toString() ?? 'jwtSignInForm',
      metadata: dto.raw,
    );
  }
}
