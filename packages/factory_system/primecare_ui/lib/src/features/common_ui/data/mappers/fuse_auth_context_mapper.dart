// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_auth_context_view_model.dart';
import '../dtos/fuse_auth_context_dto.dart';

class FuseAuthContextMapper {
  static FuseAuthContextViewModel fromDto(FuseAuthContextDto dto) {
    return FuseAuthContextViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseAuthContext',
      metadata: dto.raw,
    );
  }
}
