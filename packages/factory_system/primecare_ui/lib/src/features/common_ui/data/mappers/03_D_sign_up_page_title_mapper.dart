// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_sign_up_page_title_view_model.dart';
import '../dtos/02_M_sign_up_page_title_dto.dart';

class SignUpPageTitleMapper {
  static SignUpPageTitleViewModel fromDto(SignUpPageTitleDto dto) {
    return SignUpPageTitleViewModel(
      title: dto.raw['title']?.toString() ?? 'signUpPageTitle',
      metadata: dto.raw,
    );
  }
}
