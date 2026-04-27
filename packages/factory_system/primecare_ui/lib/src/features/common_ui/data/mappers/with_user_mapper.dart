// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/with_user_view_model.dart';
import '../dtos/with_user_dto.dart';

class WithUserMapper {
  static WithUserViewModel fromDto(WithUserDto dto) {
    return WithUserViewModel(
      title: dto.raw['title']?.toString() ?? 'withUser',
      metadata: dto.raw,
    );
  }
}
