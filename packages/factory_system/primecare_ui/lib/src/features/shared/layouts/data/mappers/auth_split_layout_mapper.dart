// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/auth_split_layout_view_model.dart';
import '../dtos/auth_split_layout_dto.dart';

class AuthSplitLayoutMapper {
  static AuthSplitLayoutViewModel fromDto(AuthSplitLayoutDto dto) {
    return AuthSplitLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'authSplitLayout',
      metadata: dto.raw,
    );
  }
}
