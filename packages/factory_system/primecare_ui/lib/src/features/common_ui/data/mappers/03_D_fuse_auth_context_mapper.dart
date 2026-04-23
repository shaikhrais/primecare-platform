// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_auth_context_view_model.dart';
import '../dtos/02_M_fuse_auth_context_dto.dart';

class FuseAuthContextMapper {
  static FuseAuthContextViewModel fromDto(FuseAuthContextDto dto) {
    return FuseAuthContextViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseAuthContext',
      metadata: dto.raw,
    );
  }
}

