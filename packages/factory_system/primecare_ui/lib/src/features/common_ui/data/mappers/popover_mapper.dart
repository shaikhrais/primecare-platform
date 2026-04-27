// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/popover_view_model.dart';
import '../dtos/popover_dto.dart';

class PopoverMapper {
  static PopoverViewModel fromDto(PopoverDto dto) {
    return PopoverViewModel(
      title: dto.raw['title']?.toString() ?? 'popover',
      metadata: dto.raw,
    );
  }
}
