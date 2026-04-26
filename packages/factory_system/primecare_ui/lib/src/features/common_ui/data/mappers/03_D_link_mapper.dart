// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_link_view_model.dart';
import '../dtos/02_M_link_dto.dart';

class LinkMapper {
  static LinkViewModel fromDto(LinkDto dto) {
    return LinkViewModel(
      title: dto.raw['title']?.toString() ?? 'link',
      metadata: dto.raw,
    );
  }
}
