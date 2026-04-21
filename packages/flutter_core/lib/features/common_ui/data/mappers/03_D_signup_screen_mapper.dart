// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_signup_screen_view_model.dart';
import '../dtos/02_M_signup_screen_dto.dart';

class SignupScreenMapper {
  static SignupScreenViewModel fromDto(SignupScreenDto dto) {
    return SignupScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'signupScreen',
      metadata: dto.raw,
    );
  }
}

