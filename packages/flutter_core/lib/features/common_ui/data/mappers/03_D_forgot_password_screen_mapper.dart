// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_forgot_password_screen_view_model.dart';
import '../dtos/02_M_forgot_password_screen_dto.dart';

class ForgotPasswordScreenMapper {
  static ForgotPasswordScreenViewModel fromDto(ForgotPasswordScreenDto dto) {
    return ForgotPasswordScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'forgotPasswordScreen',
      metadata: dto.raw,
    );
  }
}

