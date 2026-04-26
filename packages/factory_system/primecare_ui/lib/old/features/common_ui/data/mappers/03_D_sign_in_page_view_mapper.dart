// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_sign_in_page_view_view_model.dart';
import '../dtos/02_M_sign_in_page_view_dto.dart';

class SignInPageViewMapper {
  static SignInPageViewViewModel fromDto(SignInPageViewDto dto) {
    return SignInPageViewViewModel(
      title: dto.raw['title']?.toString() ?? 'signInPageView',
      metadata: dto.raw,
    );
  }
}
