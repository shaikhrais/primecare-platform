// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_link_popover_view_model.dart';
import '../dtos/02_M_link_popover_dto.dart';

class LinkPopoverMapper {
  static LinkPopoverViewModel fromDto(LinkPopoverDto dto) {
    return LinkPopoverViewModel(
      title: dto.raw['title']?.toString() ?? 'linkPopover',
      metadata: dto.raw,
    );
  }
}

