// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_fuse_auth_provider_view_model.dart';
import '../dtos/02_M_fuse_auth_provider_dto.dart';

class FuseAuthProviderMapper {
  static FuseAuthProviderViewModel fromDto(FuseAuthProviderDto dto) {
    return FuseAuthProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseAuthProvider',
      metadata: dto.raw,
    );
  }
}

