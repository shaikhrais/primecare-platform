// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_authentication_view_model.dart';
import '../dtos/02_M_authentication_dto.dart';

class AuthenticationMapper {
  static AuthenticationViewModel fromDto(AuthenticationDto dto) {
    return AuthenticationViewModel(
      title: dto.raw['title']?.toString() ?? 'authentication',
      metadata: dto.raw,
    );
  }
}

