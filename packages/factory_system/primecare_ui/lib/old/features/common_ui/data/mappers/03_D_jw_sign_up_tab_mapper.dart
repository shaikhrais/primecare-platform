// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_jw_sign_up_tab_view_model.dart';
import '../dtos/02_M_jw_sign_up_tab_dto.dart';

class JwSignUpTabMapper {
  static JwSignUpTabViewModel fromDto(JwSignUpTabDto dto) {
    return JwSignUpTabViewModel(
      title: dto.raw['title']?.toString() ?? 'jwSignUpTab',
      metadata: dto.raw,
    );
  }
}
