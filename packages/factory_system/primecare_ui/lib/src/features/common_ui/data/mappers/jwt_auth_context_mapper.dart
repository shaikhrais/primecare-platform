// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/jwt_auth_context_view_model.dart';
import '../dtos/jwt_auth_context_dto.dart';

class JwtAuthContextMapper {
  static JwtAuthContextViewModel fromDto(JwtAuthContextDto dto) {
    return JwtAuthContextViewModel(
      title: dto.raw['title']?.toString() ?? 'jwtAuthContext',
      metadata: dto.raw,
    );
  }
}
