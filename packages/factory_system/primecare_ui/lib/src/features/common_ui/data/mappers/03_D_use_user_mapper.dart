// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_use_user_view_model.dart';
import '../dtos/02_M_use_user_dto.dart';

class UseUserMapper {
  static UseUserViewModel fromDto(UseUserDto dto) {
    return UseUserViewModel(
      title: dto.raw['title']?.toString() ?? 'useUser',
      metadata: dto.raw,
    );
  }
}
