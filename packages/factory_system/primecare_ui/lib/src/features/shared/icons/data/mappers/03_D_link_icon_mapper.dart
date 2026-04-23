// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_link_icon_view_model.dart';
import '../dtos/02_M_link_icon_dto.dart';

class LinkIconMapper {
  static LinkIconViewModel fromDto(LinkIconDto dto) {
    return LinkIconViewModel(
      title: dto.raw['title']?.toString() ?? 'linkIcon',
      metadata: dto.raw,
    );
  }
}

