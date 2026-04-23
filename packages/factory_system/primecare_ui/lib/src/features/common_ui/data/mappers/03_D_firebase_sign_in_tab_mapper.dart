// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_firebase_sign_in_tab_view_model.dart';
import '../dtos/02_M_firebase_sign_in_tab_dto.dart';

class FirebaseSignInTabMapper {
  static FirebaseSignInTabViewModel fromDto(FirebaseSignInTabDto dto) {
    return FirebaseSignInTabViewModel(
      title: dto.raw['title']?.toString() ?? 'firebaseSignInTab',
      metadata: dto.raw,
    );
  }
}

