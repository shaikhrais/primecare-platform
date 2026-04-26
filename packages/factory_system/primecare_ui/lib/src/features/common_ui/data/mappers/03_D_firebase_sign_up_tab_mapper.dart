// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_firebase_sign_up_tab_view_model.dart';
import '../dtos/02_M_firebase_sign_up_tab_dto.dart';

class FirebaseSignUpTabMapper {
  static FirebaseSignUpTabViewModel fromDto(FirebaseSignUpTabDto dto) {
    return FirebaseSignUpTabViewModel(
      title: dto.raw['title']?.toString() ?? 'firebaseSignUpTab',
      metadata: dto.raw,
    );
  }
}
