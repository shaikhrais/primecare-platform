// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/initialize_firebase_view_model.dart';
import '../dtos/initialize_firebase_dto.dart';

class InitializeFirebaseMapper {
  static InitializeFirebaseViewModel fromDto(InitializeFirebaseDto dto) {
    return InitializeFirebaseViewModel(
      title: dto.raw['title']?.toString() ?? 'initializeFirebase',
      metadata: dto.raw,
    );
  }
}
