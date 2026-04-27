// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/sign_in_page_form_view_model.dart';
import '../dtos/sign_in_page_form_dto.dart';

class SignInPageFormMapper {
  static SignInPageFormViewModel fromDto(SignInPageFormDto dto) {
    return SignInPageFormViewModel(
      title: dto.raw['title']?.toString() ?? 'signInPageForm',
      metadata: dto.raw,
    );
  }
}
