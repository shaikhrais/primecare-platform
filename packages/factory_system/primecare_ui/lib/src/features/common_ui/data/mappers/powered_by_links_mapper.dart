// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/powered_by_links_view_model.dart';
import '../dtos/powered_by_links_dto.dart';

class PoweredByLinksMapper {
  static PoweredByLinksViewModel fromDto(PoweredByLinksDto dto) {
    return PoweredByLinksViewModel(
      title: dto.raw['title']?.toString() ?? 'poweredByLinks',
      metadata: dto.raw,
    );
  }
}
