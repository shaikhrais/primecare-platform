// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_a_w_s_authenticator_view_model.dart';
import '../dtos/02_M_a_w_s_authenticator_dto.dart';

class AWSAuthenticatorMapper {
  static AWSAuthenticatorViewModel fromDto(AWSAuthenticatorDto dto) {
    return AWSAuthenticatorViewModel(
      title: dto.raw['title']?.toString() ?? 'aWSAuthenticator',
      metadata: dto.raw,
    );
  }
}
