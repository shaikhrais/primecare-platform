// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_firebase_sign_up_form_view_model.dart';
import '../dtos/02_M_firebase_sign_up_form_dto.dart';

class FirebaseSignUpFormMapper {
  static FirebaseSignUpFormViewModel fromDto(FirebaseSignUpFormDto dto) {
    return FirebaseSignUpFormViewModel(
      title: dto.raw['title']?.toString() ?? 'firebaseSignUpForm',
      metadata: dto.raw,
    );
  }
}
