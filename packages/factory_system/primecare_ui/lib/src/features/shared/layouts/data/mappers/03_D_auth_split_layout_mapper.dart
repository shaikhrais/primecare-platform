// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_auth_split_layout_view_model.dart';
import '../dtos/02_M_auth_split_layout_dto.dart';

class AuthSplitLayoutMapper {
  static AuthSplitLayoutViewModel fromDto(AuthSplitLayoutDto dto) {
    return AuthSplitLayoutViewModel(
      title: dto.raw['title']?.toString() ?? 'authSplitLayout',
      metadata: dto.raw,
    );
  }
}

