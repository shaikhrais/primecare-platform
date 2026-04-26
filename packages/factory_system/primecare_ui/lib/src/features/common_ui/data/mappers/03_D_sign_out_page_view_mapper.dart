// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_sign_out_page_view_view_model.dart';
import '../dtos/02_M_sign_out_page_view_dto.dart';

class SignOutPageViewMapper {
  static SignOutPageViewViewModel fromDto(SignOutPageViewDto dto) {
    return SignOutPageViewViewModel(
      title: dto.raw['title']?.toString() ?? 'signOutPageView',
      metadata: dto.raw,
    );
  }
}
