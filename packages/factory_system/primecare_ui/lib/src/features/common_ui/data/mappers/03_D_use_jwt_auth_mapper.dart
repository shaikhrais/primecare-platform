// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_jwt_auth_view_model.dart';
import '../dtos/02_M_use_jwt_auth_dto.dart';

class UseJwtAuthMapper {
  static UseJwtAuthViewModel fromDto(UseJwtAuthDto dto) {
    return UseJwtAuthViewModel(
      title: dto.raw['title']?.toString() ?? 'useJwtAuth',
      metadata: dto.raw,
    );
  }
}

