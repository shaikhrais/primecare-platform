// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_ban_icon_view_model.dart';
import '../dtos/02_M_ban_icon_dto.dart';

class BanIconMapper {
  static BanIconViewModel fromDto(BanIconDto dto) {
    return BanIconViewModel(
      title: dto.raw['title']?.toString() ?? 'banIcon',
      metadata: dto.raw,
    );
  }
}
