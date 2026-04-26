// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_subscript_icon_view_model.dart';
import '../dtos/02_M_subscript_icon_dto.dart';

class SubscriptIconMapper {
  static SubscriptIconViewModel fromDto(SubscriptIconDto dto) {
    return SubscriptIconViewModel(
      title: dto.raw['title']?.toString() ?? 'subscriptIcon',
      metadata: dto.raw,
    );
  }
}
