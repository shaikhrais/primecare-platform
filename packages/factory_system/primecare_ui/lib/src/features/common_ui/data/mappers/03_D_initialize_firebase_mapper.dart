// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_initialize_firebase_view_model.dart';
import '../dtos/02_M_initialize_firebase_dto.dart';

class InitializeFirebaseMapper {
  static InitializeFirebaseViewModel fromDto(InitializeFirebaseDto dto) {
    return InitializeFirebaseViewModel(
      title: dto.raw['title']?.toString() ?? 'initializeFirebase',
      metadata: dto.raw,
    );
  }
}
