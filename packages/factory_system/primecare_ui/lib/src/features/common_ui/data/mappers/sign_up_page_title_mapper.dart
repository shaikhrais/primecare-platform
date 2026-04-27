// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/sign_up_page_title_view_model.dart';
import '../dtos/sign_up_page_title_dto.dart';

class SignUpPageTitleMapper {
  static SignUpPageTitleViewModel fromDto(SignUpPageTitleDto dto) {
    return SignUpPageTitleViewModel(
      title: dto.raw['title']?.toString() ?? 'signUpPageTitle',
      metadata: dto.raw,
    );
  }
}
