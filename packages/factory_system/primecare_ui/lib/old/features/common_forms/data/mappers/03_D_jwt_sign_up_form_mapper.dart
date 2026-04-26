// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_jwt_sign_up_form_view_model.dart';
import '../dtos/02_M_jwt_sign_up_form_dto.dart';

class JwtSignUpFormMapper {
  static JwtSignUpFormViewModel fromDto(JwtSignUpFormDto dto) {
    return JwtSignUpFormViewModel(
      title: dto.raw['title']?.toString() ?? 'jwtSignUpForm',
      metadata: dto.raw,
    );
  }
}
