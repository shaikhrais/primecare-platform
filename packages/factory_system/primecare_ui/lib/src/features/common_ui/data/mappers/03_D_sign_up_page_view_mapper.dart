// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_sign_up_page_view_view_model.dart';
import '../dtos/02_M_sign_up_page_view_dto.dart';

class SignUpPageViewMapper {
  static SignUpPageViewViewModel fromDto(SignUpPageViewDto dto) {
    return SignUpPageViewViewModel(
      title: dto.raw['title']?.toString() ?? 'signUpPageView',
      metadata: dto.raw,
    );
  }
}
