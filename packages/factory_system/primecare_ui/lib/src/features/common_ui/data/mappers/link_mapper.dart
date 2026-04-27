// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/link_view_model.dart';
import '../dtos/link_dto.dart';

class LinkMapper {
  static LinkViewModel fromDto(LinkDto dto) {
    return LinkViewModel(
      title: dto.raw['title']?.toString() ?? 'link',
      metadata: dto.raw,
    );
  }
}
