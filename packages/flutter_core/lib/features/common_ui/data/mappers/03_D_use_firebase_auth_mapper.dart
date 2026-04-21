// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_firebase_auth_view_model.dart';
import '../dtos/02_M_use_firebase_auth_dto.dart';

class UseFirebaseAuthMapper {
  static UseFirebaseAuthViewModel fromDto(UseFirebaseAuthDto dto) {
    return UseFirebaseAuthViewModel(
      title: dto.raw['title']?.toString() ?? 'useFirebaseAuth',
      metadata: dto.raw,
    );
  }
}

