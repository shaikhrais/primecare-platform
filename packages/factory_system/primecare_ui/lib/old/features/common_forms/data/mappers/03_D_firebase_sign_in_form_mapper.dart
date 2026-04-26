// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_firebase_sign_in_form_view_model.dart';
import '../dtos/02_M_firebase_sign_in_form_dto.dart';

class FirebaseSignInFormMapper {
  static FirebaseSignInFormViewModel fromDto(FirebaseSignInFormDto dto) {
    return FirebaseSignInFormViewModel(
      title: dto.raw['title']?.toString() ?? 'firebaseSignInForm',
      metadata: dto.raw,
    );
  }
}
