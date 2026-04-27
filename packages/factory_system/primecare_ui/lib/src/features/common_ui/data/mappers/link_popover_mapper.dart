// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/link_popover_view_model.dart';
import '../dtos/link_popover_dto.dart';

class LinkPopoverMapper {
  static LinkPopoverViewModel fromDto(LinkPopoverDto dto) {
    return LinkPopoverViewModel(
      title: dto.raw['title']?.toString() ?? 'linkPopover',
      metadata: dto.raw,
    );
  }
}
