// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_jwt_auth_provider_view_model.dart';
import '../dtos/02_M_jwt_auth_provider_dto.dart';

class JwtAuthProviderMapper {
  static JwtAuthProviderViewModel fromDto(JwtAuthProviderDto dto) {
    return JwtAuthProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'jwtAuthProvider',
      metadata: dto.raw,
    );
  }
}

