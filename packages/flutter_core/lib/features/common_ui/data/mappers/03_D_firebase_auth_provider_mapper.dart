// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_firebase_auth_provider_view_model.dart';
import '../dtos/02_M_firebase_auth_provider_dto.dart';

class FirebaseAuthProviderMapper {
  static FirebaseAuthProviderViewModel fromDto(FirebaseAuthProviderDto dto) {
    return FirebaseAuthProviderViewModel(
      title: dto.raw['title']?.toString() ?? 'firebaseAuthProvider',
      metadata: dto.raw,
    );
  }
}

