// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/fuse_authorization_view_model.dart';
import '../dtos/fuse_authorization_dto.dart';

class FuseAuthorizationMapper {
  static FuseAuthorizationViewModel fromDto(FuseAuthorizationDto dto) {
    return FuseAuthorizationViewModel(
      title: dto.raw['title']?.toString() ?? 'fuseAuthorization',
      metadata: dto.raw,
    );
  }
}
