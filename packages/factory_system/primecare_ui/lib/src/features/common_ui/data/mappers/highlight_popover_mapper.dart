// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/highlight_popover_view_model.dart';
import '../dtos/highlight_popover_dto.dart';

class HighlightPopoverMapper {
  static HighlightPopoverViewModel fromDto(HighlightPopoverDto dto) {
    return HighlightPopoverViewModel(
      title: dto.raw['title']?.toString() ?? 'highlightPopover',
      metadata: dto.raw,
    );
  }
}
