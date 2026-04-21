// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_a_w_s_auth_provider_view_model.dart';
import '../dtos/02_M_a_w_s_auth_provider_dto.dart';

class AWSAuthProviderMapper {
  static AWSAuthProviderViewModel fromDto(AWSAuthProviderDto dto) {
    return AWSAuthProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'aWSAuthProvider',
      metadata: dto.raw,
    );
  }
}

