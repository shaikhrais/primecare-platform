// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/auth_layout_view_model.dart';
import '../dtos/auth_layout_dto.dart';

class AuthLayoutMapper {
  static AuthLayoutViewModel fromDto(AuthLayoutDto dto) {
    return AuthLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'authLayout',
      metadata: dto.raw,
    );
  }
}
