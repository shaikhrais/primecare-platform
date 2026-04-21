// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_mfa_screen_view_model.dart';
import '../dtos/02_M_mfa_screen_dto.dart';

class MfaScreenMapper {
  static MfaScreenViewModel fromDto(MfaScreenDto dto) {
    return MfaScreenViewModel(
      title: dto.raw['title']?.toString() ?? 'mfaScreen',
      metadata: dto.raw,
    );
  }
}

