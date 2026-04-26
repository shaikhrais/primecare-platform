// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_with_user_view_model.dart';
import '../dtos/02_M_with_user_dto.dart';

class WithUserMapper {
  static WithUserViewModel fromDto(WithUserDto dto) {
    return WithUserViewModel(
      title: dto.raw['title']?.toString() ?? 'withUser',
      metadata: dto.raw,
    );
  }
}
