// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_sign_in_page_title_view_model.dart';
import '../dtos/02_M_sign_in_page_title_dto.dart';

class SignInPageTitleMapper {
  static SignInPageTitleViewModel fromDto(SignInPageTitleDto dto) {
    return SignInPageTitleViewModel(
      title: dto.raw['title']?.toString() ?? 'signInPageTitle',
      metadata: dto.raw,
    );
  }
}
