// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_external_link_icon_view_model.dart';
import '../dtos/02_M_external_link_icon_dto.dart';

class ExternalLinkIconMapper {
  static ExternalLinkIconViewModel fromDto(ExternalLinkIconDto dto) {
    return ExternalLinkIconViewModel(
      title: dto.raw['title']?.toString() ?? 'externalLinkIcon',
      metadata: dto.raw,
    );
  }
}

