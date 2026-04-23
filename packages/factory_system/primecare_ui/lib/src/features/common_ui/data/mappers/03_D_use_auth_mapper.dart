// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_auth_view_model.dart';
import '../dtos/02_M_use_auth_dto.dart';

class UseAuthMapper {
  static UseAuthViewModel fromDto(UseAuthDto dto) {
    return UseAuthViewModel(
      title: dto.raw['title']?.toString() ?? 'useAuth',
      metadata: dto.raw,
    );
  }
}

