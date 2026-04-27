// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/sign_out_page_view_view_model.dart';
import '../dtos/sign_out_page_view_dto.dart';

class SignOutPageViewMapper {
  static SignOutPageViewViewModel fromDto(SignOutPageViewDto dto) {
    return SignOutPageViewViewModel(
      title: dto.raw['title']?.toString() ?? 'signOutPageView',
      metadata: dto.raw,
    );
  }
}
