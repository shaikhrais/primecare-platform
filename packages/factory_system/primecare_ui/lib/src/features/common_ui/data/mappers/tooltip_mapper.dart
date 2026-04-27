// Layer: 03_DATA_DOMAIN_LOGIC
import '../../domain/models/tooltip_view_model.dart';
import '../dtos/tooltip_dto.dart';

class TooltipMapper {
  static TooltipViewModel fromDto(TooltipDto dto) {
    return TooltipViewModel(
      title: dto.raw['title']?.toString() ?? 'tooltip',
      metadata: dto.raw,
    );
  }
}
