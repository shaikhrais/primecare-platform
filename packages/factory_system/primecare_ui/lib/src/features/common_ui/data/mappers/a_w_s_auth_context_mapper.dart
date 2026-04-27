// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/a_w_s_auth_context_view_model.dart';
import '../dtos/a_w_s_auth_context_dto.dart';

class AWSAuthContextMapper {
  static AWSAuthContextViewModel fromDto(AWSAuthContextDto dto) {
    return AWSAuthContextViewModel(
      title: dto.raw['title']?.toString() ?? 'aWSAuthContext',
      metadata: dto.raw,
    );
  }
}
