// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/firebase_auth_context_view_model.dart';
import '../dtos/firebase_auth_context_dto.dart';

class FirebaseAuthContextMapper {
  static FirebaseAuthContextViewModel fromDto(FirebaseAuthContextDto dto) {
    return FirebaseAuthContextViewModel(
      title: dto.raw['title']?.toString() ?? 'firebaseAuthContext',
      metadata: dto.raw,
    );
  }
}
