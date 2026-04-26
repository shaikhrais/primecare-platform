// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/02_M_popover_view_model.dart';
import '../dtos/02_M_popover_dto.dart';

class PopoverMapper {
  static PopoverViewModel fromDto(PopoverDto dto) {
    return PopoverViewModel(
      title: dto.raw['title']?.toString() ?? 'popover',
      metadata: dto.raw,
    );
  }
}
