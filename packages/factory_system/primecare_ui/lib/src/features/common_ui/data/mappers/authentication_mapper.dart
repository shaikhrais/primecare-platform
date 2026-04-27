// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/authentication_view_model.dart';
import '../dtos/authentication_dto.dart';

class AuthenticationMapper {
  static AuthenticationViewModel fromDto(AuthenticationDto dto) {
    return AuthenticationViewModel(
      title: dto.raw['title']?.toString() ?? 'authentication',
      metadata: dto.raw,
    );
  }
}
