// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_auth_pages_message_section_view_model.dart';
import '../dtos/02_M_auth_pages_message_section_dto.dart';

class AuthPagesMessageSectionMapper {
  static AuthPagesMessageSectionViewModel fromDto(
    AuthPagesMessageSectionDto dto,
  ) {
    return AuthPagesMessageSectionViewModel(
      title: dto.raw['title']?.toString() ?? 'authPagesMessageSection',
      metadata: dto.raw,
    );
  }
}
