// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_auth_layout_view_model.dart';
import '../dtos/02_M_auth_layout_dto.dart';

class AuthLayoutMapper {
  static AuthLayoutViewModel fromDto(AuthLayoutDto dto) {
    return AuthLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'authLayout',
      metadata: dto.raw,
    );
  }
}
