// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/sign_out_page_title_view_model.dart';
import '../dtos/sign_out_page_title_dto.dart';

class SignOutPageTitleMapper {
  static SignOutPageTitleViewModel fromDto(SignOutPageTitleDto dto) {
    return SignOutPageTitleViewModel(
      title: dto.raw['title']?.toString() ?? 'signOutPageTitle',
      metadata: dto.raw,
    );
  }
}
